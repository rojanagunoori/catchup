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

  def like
    @thought = Thought.find(params[:id])
    #like = @thought.likes.find_by(user: current_user)
    like = Like.find_by(user: current_user, thought: @thought)

    if like
      like.destroy
    else
      #@thought.likes.create(user: current_user)
      @thought.likes.create(user: current_user, thought_id: @thought.id) # ✅ Ensure thought_id is set
    end

    redirect_to thoughts_path
  end

  private

  def thought_params
    params.require(:thought).permit(:content)
  end
end
