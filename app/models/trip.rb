class Trip < ApplicationRecord
  validates_presence_of :destination, :lat, :lng, :days

  has_many :activity_types
end
