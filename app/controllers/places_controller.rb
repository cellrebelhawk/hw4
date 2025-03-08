class PlacesController < ApplicationController

  def index
    @places = Place.all.where({"user_id" => session["user_id"]})
  end

  def show
    @places = Place.find_by({ "id" => params["id"], "user_id" => session["user_id"]})
    @entries = Entry.where({ "place_id" => @places["id"], "user_id" => session["user_id"]})
  end

  def new
  end

  def create
    @places = Place.new
    @places["name"] = params["name"]
    @places["user_id"] = params["user_id"]
    @places.save
    redirect_to "/places"
  end

end
