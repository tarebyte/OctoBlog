class PostsController < ApplicationController

  before_action :set_user
  before_action :set_repo
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = @repo.posts.accessible_by(current_ability)
      .desc(:updated_at).desc(:created_at)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new user_id: @user.id, repo_id: @repo.id
    authorize! @post, :create
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @repo.posts.new(post_params)
    authorize! @post, :create

    @post.user_id = @user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_repo_post_path @user, @repo, @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_repo_post_path, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_repo_posts_path}
      format.json { head :no_content }
    end
  end

  private
    def set_post
      # replace load_and_authorize_resources
      @post = @repo.posts.find(params[:id])
      authorize! action_name.to_sym, @post
    end

    def set_repo
      @repo = @user.repos.where(name: params[:repo_id]).first
    end

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
