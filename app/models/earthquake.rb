class Earthquake < ActiveRecord::Base
  attr_accessible :date, :latitude, :longitude, :magnitude
end
