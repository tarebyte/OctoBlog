class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def index
    @user = User.all
  end

  def show
  end

  private

  def set_user
    @user = params[:id].present? ?
      User.friendly.find(params[:id]) : current_user
  end
end
