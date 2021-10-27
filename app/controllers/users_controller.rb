class UsersController < ApplicationController

  #before_action :authenticate_user!, except: [:index]

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params.require(:user).permit(:name, :introduction, :avatar))
      flash[:notice] = "#{@user.name}さんのユーザー情報を更新しました"
      redirect_to(users_profile_path(current_user.id))
    else
      flash[:alert] = "更新できませんでした。"
      render "profile"
    end
  end
  
  
=begin
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザーを新規登録しました"
      redirect_to("/")
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirm)
    end
=end
end


