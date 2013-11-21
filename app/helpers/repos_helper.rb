module ReposHelper

  def get_unused_repos
    get_github_repos - get_users_repos
  end

  private

  def get_github_repos
    client = Octokit::Client.new
    client.list_repositories(params[:user_id], { per_page: 1000 }).map { |repo| repo.name }
  end

  def get_users_repos
    Repo.where(user_id: current_user.id).map { |repo| repo.name }
  end
end
