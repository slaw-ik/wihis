class Activity < ActiveRecord::Base
  attr_accessible :point_id, :text, :user_id
  belongs_to :user
  belongs_to :point

  def self.leave(user_id, point_id, data)
    self.create(:user_id => user_id,
                :point_id => point_id,
                :text => "#{data}")
  end
end
