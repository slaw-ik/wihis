class Point < ActiveRecord::Base

  has_and_belongs_to_many :tags

  validates :description, :presence => true

  acts_as_gmappable :process_geocoding => true, :validation => false
  before_create :address_presence


  attr_accessible :address, :gmaps, :description, :latitude, :longitude, :no_geocode
  attr_accessor :no_geocode

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
    Point.acts_as_gmappable :process_geocoding => !self.address.blank? && !self.no_geocode, :validation => false
    return true
  end
end
