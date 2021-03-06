class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :cannot_edit, only: [:update, :edit]
  before_action :authorize_destroy, only: [:destroy]
  before_action :redirect_to_thread, only: [:show, :index]

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
    @post = @forumthread.posts.create(params[:post].permit(:body))
    @post.user_id = current_user.id if current_user
    @post.save
    # Increment thread's replycount with each new post
    @forumthread.replycount += 1
    @forumthread.save

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
  end

  # Increment report weight on post
  def report
    @post = Post.find(params[:id])
    @post.report_weight += 1
    @post.save
    flash[:notice] = "Reported post."
    redirect_to forumthread_path(@post.forumthread.id)
  end

  def reset_reports
    @post = Post.find(params[:id])
    @post.report_weight = 0
    @post.save
    flash[:notice] = "Reset reports on post."
    redirect_to request.referrer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body)
    end

    def cannot_edit
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
      if @post.user.role == 0
        flash[:notice] = "You do not have permission to delete posts."
        redirect_to request.referrer
      else
        ban_post
        flash[:notice] = "Successfully banned post."
        redirect_to request.referrer
      end
    end

    def redirect_to_thread
      # Redirect to thread page instead of showing post or post index
      redirect_to forumthread_url(params[:forumthread_id])
    end

    # Set post to banned
    def ban_post
      @post.is_banned = true
      @post.save
    end
end
