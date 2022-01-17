class AdminController < ApplicationController
    def index
        @forumthreads = Forumthread.where('report_weight > ?', 0).where('is_banned = ?', false).order("report_weight DESC")
        @posts = Post.where('report_weight > ?', 0).where('is_banned = ?', false).order("report_weight DESC")
    end
end
