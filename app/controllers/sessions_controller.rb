class SessionsController < ApplicationController

  def new
    if session[:user_id]
      redirect_to "/games"
    end
  end


  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.first_name}!"
      redirect_to "/games"
    else
      flash[:danger] = "Invalid email or password!"
      redirect_to "/login"
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      flash[:success] = "You have successfully logged out!"
      redirect_to "/login"
    else
      redirect_to "/login"
    end
  end

end
