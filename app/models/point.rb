class Point < ActiveRecord::Base

  has_and_belongs_to_many :tags
  has_many :activities

  validates :description, :presence => true
  #validates :tags, :uniqueness => true

  acts_as_gmappable :process_geocoding => true, :validation => false
  before_create :address_presence


  attr_accessible :address, :gmaps, :description, :latitude, :longitude, :no_geocode, :tags
  attr_accessor :no_geocode

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def gmaps4rails_address
    address
  end

  #def gmaps4rails_infowindow
  #  "<h4>#{address}</h4>"
  #end

  def self.prepare_parameters(data)

    n_tags = []
    ex_tags = []
    tags = []

    unless data[:'tag-n'].blank?
      new_tags = data[:"tag-n"]
      new_tags.each do |tag|
        n_tags << Tag.new(:name => tag)
      end
      tags += new_tags
    end

    unless data[:tag].blank?
      exist_tag_ids = data[:tag].keys
      exist_tag_names = data[:tag].values
      ex_tags = Tag.where('id in (?)', exist_tag_ids)
      tags += exist_tag_names
    end

    data[:no_geocode] = true
    data[:tags] = n_tags + ex_tags
    data.delete(:tag)
    data.delete(:'tag-n')

    return {:point => self.new(data), :tags => tags.join(', ')}

    #todo
    #  need to refactor
    #  need some tests

  end

  private

  def address_presence
    Point.acts_as_gmappable :process_geocoding => !self.address.blank? && !self.no_geocode, :validation => false
    return true
  end
end
