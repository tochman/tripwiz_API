class Trip < ApplicationRecord
  validates_presence_of :destination, :coord_lat, :coord_lng
end
