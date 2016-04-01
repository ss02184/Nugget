class PostsController < ApplicationController
	def show
		@post = Post.includes(comments: [:user]).find(params[:id])
	end

	def index
		@posts = Post.includes(:user).all.paginate(page: params[:page], per_page: 5).order("created_at DESC")
	end

	def subindex
		if(current_user && !@tester)
			user_ids = current_user.timeline_user_ids
			@posts = Post.includes(:user).where(user_id: user_ids).paginate(page: params[:page], per_page: 5).order("created_at DESC")	
		end
	end
end