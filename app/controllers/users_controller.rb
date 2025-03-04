class UsersController < ApplicationController
  def new
  end

  def create
    if User.find_by({ "email" => params["email"] }) == nil
      @user = User.new
      @user["first_name"] = params["first_name"]
      @user["last_name"] = params["last_name"]
      @user["email"] = params["email"]
      # TODO: encrypt user's password "at rest"
      @user["password"] = BCrypt::Password.create(params["password"])
      if @user.save
        redirect_to "/posts" 
        flash["notice"] = "Account created successfully!"
      else
        flash["notice"] = "Something went wrong. Please try again."
        redirect_to "users/new"
      end
    else
      flash["notice"] = "Email already taken."
    
    end
  end
end
