class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @user = User.all
  end

  def show
  end

  private

  def set_user
    if params[:id].present?
      @user = User.friendly.find(params[:id]) if params[:id].present?
    elsif current_user
      @user = current_user
    end
  end
end
