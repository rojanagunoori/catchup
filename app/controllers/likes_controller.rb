class LikesController < ApplicationController
    before_action :require_user
  
    def toggle_like
      thought = Thought.find(params[:thought_id])
      like = thought.likes.find_by(user: current_user)
  
      if like
        like.destroy
        liked = false
      else
        thought.likes.create(user: current_user)
        liked = true
      end
  
      render json: { liked: liked, likes_count: thought.likes.count }
    end
  end
  