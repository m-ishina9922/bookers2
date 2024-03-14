class UsersController < ApplicationController
  before_action :move_to_signed_in, only: [:edit, :update, :show, :index]

  def show
    move_to_signed_in
    @user = User.find(params[:id])
    @users = @user.books
  end

  def edit
    move_to_signed_in
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    move_to_signed_in
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path
    else
       render 'edit'
    end
  end

  def index
    move_to_signed_in
    @user =User.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def move_to_signed_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
