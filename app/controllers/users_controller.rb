class UsersController < ApplicationController

  def new

  end

  def create
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
      )
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome #{params[:first_name]}!"
      redirect_to '/games'
    else
      flash[:danger] = "Error"
      redirect_to '/sign_up'
    end
  end

end
