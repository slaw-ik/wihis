class PointsController < ApplicationController
  def index
    @json = Point.all.to_gmaps4rails
  end

  def get_address
    @address = Geocoder.search(params[:"latLng"])[0].data["formatted_address"]
    render :text => @address
  end
end
