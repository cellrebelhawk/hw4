class EntriesController < ApplicationController

  def new
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place_name = Place.find_by({ "id" => params["place_id"]})["name"]
    else
      flash["notice"] = "Log in first before accessing this page."
      redirect_to "/login"
	  end
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry.uploaded_image.attach(params["uploaded_image"])
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = params["user_id"]
    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
