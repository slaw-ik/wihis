class PointsController < ApplicationController
  def index
    @json = Point.all.to_gmaps4rails
  end
end
