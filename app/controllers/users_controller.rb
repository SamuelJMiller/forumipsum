class UsersController < ApplicationController
  before_action :update_last_sign_in_at

  def index
    @users = User.search(params[:search])
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  protected

  def update_last_sign_in_at
    if user_signed_in? && !session[:logged_signin]
      sign_in(current_user, :force => true)
      session[:logged_signin] = true
    end
  end
end
