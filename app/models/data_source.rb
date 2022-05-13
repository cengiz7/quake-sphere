class DataSource < ApplicationRecord
  has_many :earthquakes
  
  validates :slug, presence: true, uniqueness: true

  def serialize
    DataSourceSerializer.new(self)
  end
end
