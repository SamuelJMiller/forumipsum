class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_item, only: [:update, :edit]
  before_action :authorize_destroy, only: [:destroy]

  # GET /posts or /posts.json
  def index
    @forumthread = Forumthread.find(params[:forumthread_id])
    @posts = @forumthread.posts.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
    # new needs the forumthread_id also
    @post.forumthread_id = params[:forumthread_id]
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @forumthread = Forumthread.find(params[:forumthread_id])
    # Have to allow all the columns
    @post = @forumthread.posts.create(params[:post].permit(:user_id, :forumthread_id, :body, :feedback_score, :is_banned))
    @post.user_id = current_user.id if current_user
    @post.save

    respond_to do |format|
      if @post.save
        format.html { redirect_to forumthread_post_path(@post.forumthread.id, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to forumthread_post_path(@post.forumthread.id, @post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to forumthread_posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :forumthread_id, :body, :feedback_score, :is_banned)
    end

    def authorize_item
      # Nobody can edit posts
      if @post.user != current_user
        flash[:notice] = "That's not yours."
        redirect_to forumthread_posts_url
      else
        flash[:notice] = "You cannot edit posts after they have been published."
        redirect_to forumthread_posts_url
      end
    end

    def authorize_destroy
      # Only Mod+ can delete posts
      unless @post.user.role > 0
        flash[:notice] = "You do not have permission to delete posts."
        redirect_to forumthread_posts_url
      end
    end
end
