# app/controllers/thoughts_controller.rb
class ThoughtsController < ApplicationController
    before_action :require_user
    
    def index
      @thought = Thought.new
      @thoughts = Thought.includes(:user).order(created_at: :desc)
    end
    
    def create
      @thought = current_user.thoughts.build(thought_params)
      if @thought.save
        redirect_to thoughts_path, notice: "Thought shared!"
      else
        @thoughts = Thought.includes(:user).order(created_at: :desc)
        render :index
      end
    end
    
    private
    
    def thought_params
      params.require(:thought).permit(:content)
    end
  end
  

