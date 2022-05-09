class Earthquake < ApplicationRecord
  reverse_geocoded_by :lat, :long

  belongs_to :main, class_name: 'Earthquake', optional: true
  has_many :sub_records, class_name: 'Earthquake', foreign_key: 'main_id'

  validates :lat, presence: true, numericality: { in: -90..90 }
  validates :long, presence: true, numericality: { in: -180..180 }
  validates :depth, presence: true, numericality: true
  validates :magnitude, presence: true, numericality: true
  validates :time, presence: true

  before_create :associate_earthquake

  def associate_earthquake
    near_quakes = Earthquake.near([self.lat, self.long], 5, units: :km)
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
end
