class ForumthreadsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_forumthread, only: %i[ show edit update destroy ]
  before_action :cannot_edit, only: [:update, :edit]
  before_action :authorize_destroy, only: [:destroy]

  after_action  :set_category, only: [:create]

  # GET /forumthreads or /forumthreads.json
  def index
    @categories = Category.all
    @forumthreads = Forumthread.all
  end

  # GET /forumthreads/1 or /forumthreads/1.json
  def show
  end

  # GET /forumthreads/new
  def new
    @forumthread = current_user.forumthreads.build
  end

  # GET /forumthreads/1/edit
  def edit
  end

  # POST /forumthreads or /forumthreads.json
  def create
    @forumthread = current_user.forumthreads.build(forumthread_params)

    respond_to do |format|
      if @forumthread.save
        # Redirect to main page after creation
        format.html { redirect_to root_path, notice: "Forumthread was successfully created." }
        format.json { render :show, status: :created, location: @forumthread }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @forumthread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forumthreads/1 or /forumthreads/1.json
  def update
    respond_to do |format|
      if @forumthread.update(forumthread_params)
        format.html { redirect_to @forumthread, notice: "Forumthread was successfully updated." }
        format.json { render :show, status: :ok, location: @forumthread }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @forumthread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forumthreads/1 or /forumthreads/1.json
  def destroy
  end

  def report
    @forumthread = Forumthread.find(params[:id])
    @forumthread.report_weight += 1
    @forumthread.save
    flash[:notice] = "Reported thread #{@forumthread.title}."
    redirect_to root_path
  end

  def reset_reports
    @forumthread = Forumthread.find(params[:id])
    @forumthread.report_weight = 0
    @forumthread.save
    flash[:notice] = "Reset reports on #{@forumthread.title}."
    redirect_to request.referrer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forumthread
      @forumthread = Forumthread.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def forumthread_params
      params.require(:forumthread).permit(:title, :initial_post, :category)
    end

    def cannot_edit
      # Nobody can edit threads
      if @forumthread.user != current_user
        flash[:notice] = "That's not yours."
        redirect_to root_path
      else
        flash[:notice] = "You cannot edit threads after they have been created."
        redirect_to root_path
      end
    end

    def authorize_destroy
      # Only Mod+ can delete threads
      if @forumthread.user.role == 0
        flash[:notice] = "You do not have permission to delete threads."
        redirect_to request.referrer
      else
        ban_thread
        flash[:notice] = "Banned thread #{@forumthread.title}."
        redirect_to request.referrer
      end
    end

    # Set thread to banned
    def ban_thread
      @forumthread.is_banned = true
      @forumthread.save
    end

    # Runs after create
    def set_category
      @forumthread.category = Category.find(params[:category_id]).name
      @forumthread.save
    end
end
