class ReposController < ApplicationController

  before_action :set_user, except: [:list]
  before_action :set_repo, only: [:show, :edit, :update, :destroy]

  # GET /repos
  # GET /repos.json
  def index
    @repos = Repo.where user_id: @user.id
  end

  def list
    @repos = Repo.all.desc("_id")
  end

  # GET /repos/1
  # GET /repos/1.json
  def show
  end

  # GET /repos/new
  def new
    @repo = Repo.new
  end

  # GET /repos/1/edit
  def edit
  end

  # POST /repos
  # POST /repos.json
  def create
    @repo = Repo.new(repo_params)

    @repo.user = current_user

    @repo.user_id = current_user.id
    @repo.description = get_repo_description(@repo.name)
    @repo.url = "http://github.com/#{current_user.username}/#{@repo.name}"

    authorize! :create, @repo

    respond_to do |format|
      if @repo.save
        format.html { redirect_to user_repo_posts_path(@user.username, @repo.slug), notice: 'Repo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @repo }
      else
        format.html { render action: 'new' }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repos/1
  # PATCH/PUT /repos/1.json
  def update
    respond_to do |format|
      if @repo.update(repo_params)
        format.html { redirect_to @repo, notice: 'Repo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy

    @repo.destroy
    respond_to do |format|
      format.html { redirect_to user_repos_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repo
      puts "set_repo"
      # replace load_and_authorize_resources
      @repo = @user.repos.find(params[:id])
      puts "\n\n\n"
      puts action_name.to_sym
      puts "\n\n\n"
      authorize! action_name.to_sym, @repo
    end

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repo_params
      params.require(:repo).permit(:name)
    end

    def get_repo_description(repo_name)
      client = Octokit::Client.new
      client.repository("#{current_user.username}/#{repo_name}").description
    end
end
