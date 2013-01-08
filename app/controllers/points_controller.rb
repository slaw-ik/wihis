class PointsController < ApplicationController
  def index
    @point = Point.new
    @json = Point.all.to_gmaps4rails
  end

  def get_address
    @address = Geocoder.search(params[:"latLng"])[0].data["formatted_address"]
    render :text => @address
  end

  def create
    data = params[:point]
    #data[:no_geocode] = true
    #@point = Point.new data
    #if @point.save
    #  redirect_to :action => :index
    #  return
    #else
    #  redirect_to :action => :index
    #  return
    #end

  #  =======================================
  #
  #  Tag.find(:all, :conditions => ['tags.id not in (?)',Point.first.tags.find(:all, :select => 'tags.id').uniq.map {|x| x.id}] )
  end
end
