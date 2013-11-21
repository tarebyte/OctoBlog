class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show

    # Set up news feed.

    # get the list of people the user is following
    usernames = Octokit.following(@user.username, { page_limit: 1000 }).map {|u| u.login }

    # grab their ids
    user_ids = User.where(username: usernames).pluck :id

    # get 20 of the latest posts by these users
    @posts = Post.in(user_id: user_ids)
      .desc(:updated_at).desc(:created_at).limit(20)
  end

  private

  def set_user
    @user = params[:id].present? ?
      User.friendly.find(params[:id]) : current_user
  end
end
