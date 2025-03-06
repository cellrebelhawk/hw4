class UsersController < ApplicationController
  def show
    @user = User.find_by({ "id" => params["id"] })
  end

  def new
  end

  def create
    if User.find_by({"email" => params["email"].downcase})
      redirect_to "/sessions/new"
      flash["notice"] = "User already exists, log in here!"
  else
    @user = User.new
    @user["first_name"] = params["first_name"]
    @user["last_name"] = params["last_name"]
    @user["email"] = params["email"]
    @user["password"] = BCrypt::Password.create(params["password"])
    @user.save
    session["user_id"] = @user["id"]
    redirect_to "/users/#{@user["id"]}"
  end
  end
end
