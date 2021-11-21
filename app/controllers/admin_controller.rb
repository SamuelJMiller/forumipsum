class AdminController < ApplicationController
    def index
        @forumthreads = Forumthread.order("report_weight DESC")
        @posts = Post.order("report_weight DESC")
    end
end
