class ForumthreadsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_forumthread, only: %i[ show edit update destroy ]
  before_action :authorize_item, only: [:update, :edit, :destroy]

  # GET /forumthreads or /forumthreads.json
  def index
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
        format.html { redirect_to @forumthread, notice: "Forumthread was successfully created." }
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
    @forumthread.destroy
    respond_to do |format|
      format.html { redirect_to forumthreads_url, notice: "Forumthread was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forumthread
      @forumthread = Forumthread.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def forumthread_params
      params.require(:forumthread).permit(:title, :replycount)
    end

    def authorize_item
      unless @forumthread.user == current_user
        redirect_to root_path, error: "You do not have permission to do that."
      end
    end
end
