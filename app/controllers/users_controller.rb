class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_corresponding_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "All right, let's get started #{@user.username}!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account information has been updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_corresponding_user
    if current_user != @user
      flash[:danger] = "You can only edit your own profile!"
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end