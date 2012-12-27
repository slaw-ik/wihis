class Point < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => true
  before_create :address_presence


  attr_accessible :address, :gmaps, :description, :latitude, :longitude

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def gmaps4rails_address
    address
  end

  def gmaps4rails_infowindow
    "<h4>#{address}</h4>"
  end

  private

  def address_presence
    Point.acts_as_gmappable :process_geocoding => !self.address.blank?
  end
end
