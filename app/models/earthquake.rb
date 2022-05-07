class Earthquake < ApplicationRecord
  reverse_geocoded_by :lat, :long
  after_validation :reverse_geocode

  belongs_to :main, class_name: 'Earthquake', optional: true
  has_many :sub_records, class_name: 'Earthquake', foreign_key: 'main_id'
end
