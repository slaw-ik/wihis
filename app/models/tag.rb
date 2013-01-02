class Tag < ActiveRecord::Base
  has_and_belongs_to_many :points
  attr_accessible :name
end
