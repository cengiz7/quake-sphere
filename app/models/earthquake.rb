class Earthquake < ApplicationRecord
  reverse_geocoded_by :lat, :long

  belongs_to :main, class_name: 'Earthquake', optional: true
  belongs_to :data_source
  has_many   :sub_records, class_name: 'Earthquake', foreign_key: 'main_id'

  validates :lat, presence: true, numericality: { in: -90..90 }
  validates :long, presence: true, numericality: { in: -180..180 }
  validates :depth, presence: true, numericality: true
  validates :magnitude, presence: true, numericality: true
  validates :time, presence: true

  scope :ordered, -> { order("time desc") }
  scope :mains, -> { where(main_id: nil) }
  scope :sub_records, -> { where.not(main_id: nil) }
  scope :today, -> { where('time > ?', Time.now.beginning_of_day) }
  scope :last_three_days, -> { where('time > ?', Time.now - 3.days) }
  scope :this_month, -> { where('time > ?', Time.now.last_month.beginning_of_month) }
  scope :last_month, -> { where('time between ? and ?',Time.now.last_month.beginning_of_month,
                                                       Time.now.last_month.end_of_month) }



  before_create :associate_earthquake
  # TODO: after_create_commit :broadcast_quake 


  def associate_earthquake
    near_quakes = Earthquake.near([self.lat, self.long], 60, units: :km)
                                    .where(main_id: nil)
                                    .where("time between ? and ?",
                                        self.time-15.seconds,
                                        self.time+15.seconds).to_a

    if near_quakes.one?
        self.main_id = near_quakes.pluck(:id).first
    elsif near_quakes.many?
        self.main_id = near_quakes.min_by { |e| self.distance_to e }.id
    end
  end

  def is_duplicate?
    s = self
    Earthquake
      .where("time between ? and ?", s.time-60, s.time+60)
      .where(
        lat: s.lat, long: s.long, depth: s.depth,
        magnitude: s.magnitude, time: s.time,
        data_source_id: s.data_source_id).any?
  end


  def serialize
    EarthquakeSerializer.new(self)
  end

  def broadcast_quake
    ActionCable.server.broadcast( 'earthquake_channel', self.as_json )
  end
end
