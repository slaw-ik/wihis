class Point < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => true
  attr_accessible :address, :gmaps, :description, :latitude, :longitude

  def gmaps4rails_address
    address
  end

  def gmaps4rails_infowindow
    "<h4>#{address}</h4>"
  end
end
