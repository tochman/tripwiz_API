class Trip < ApplicationRecord
  validates_presence_of :name, :coord_lat, :coord_lng
end
