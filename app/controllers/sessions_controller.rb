class SessionsController < ApplicationController
  def new
  end

  def create
    # Find user
    @user = User.find_by({"email" => params["email"]})
    # If user exists, check if they know password
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome!"
        redirect_to "/users/#{@user["id"]}"
      else
      flash["notice"] = "Your username or password are incorrect or do not exist"
        redirect_to "/sessions/new"
      end
    # 4. if the user doesn't exist or they don't know their password -> login fails
    else
      flash["notice"] = "Your username or password are incorrect or do not exist"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    # logout the user
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/login"
  end
end
  