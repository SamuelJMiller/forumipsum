class AdminController < ApplicationController
    def index
        @forumthreads = Forumthread.where('report_weight > ?', 0).order("report_weight DESC")
        @posts = Post.where('report_weight > ?', 0).order("report_weight DESC")
    end
end
