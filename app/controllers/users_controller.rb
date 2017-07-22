class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Alpha Blog #{@user.fullname}."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :fullname, :email, :password)
    end


end