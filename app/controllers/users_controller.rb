class UsersController < ApplicationController
  before_action :update_last_sign_in_at
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :ban_user, only: [:destroy]

  def index
    @users = User.search(params[:search])
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def destroy
  end

  protected

  def update_last_sign_in_at
    if user_signed_in? && !session[:logged_signin]
      sign_in(current_user, :force => true)
      session[:logged_signin] = true
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ban_user
    @user.is_banned = true
    @user.save
    redirect_to user_path(@user)
  end
end
