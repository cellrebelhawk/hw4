class PlacesController < ApplicationController

  def index
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @places = Place.all.where({"user_id" => session["user_id"]})
    else
      flash["notice"] = "Log in first before accessing this page."
      redirect_to "/login"
    end
  end

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @places = Place.find_by({ "id" => params["id"], "user_id" => session["user_id"]})
      @entries = Entry.where({ "place_id" => @places["id"], "user_id" => session["user_id"]})
    else
      flash["notice"] = "Log in first before accessing this page."
      redirect_to "/login"
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
    else
      flash["notice"] = "Log in first before accessing this page."
      redirect_to "/login"
    end
  end

  def create
    @places = Place.new
    @places["name"] = params["name"]
    @places["user_id"] = params["user_id"]
    @places.save
    redirect_to "/places"
  end

end
