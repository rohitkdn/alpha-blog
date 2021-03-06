class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def index
    @users = User.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Alpha Blog #{@user.fullname}."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
        if @user.update(user_params)
      flash[:success] = "Profile successfully updated."
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5).order(updated_at: :desc)
  end

  def destroy
    @user.destroy
    if @user == current_user
      session[:user_id] = nil
    end
    flash[:success] = "User successfully deleted"
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :fullname, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can edit or delete only your profile"
        redirect_to root_path
      end
    end
end