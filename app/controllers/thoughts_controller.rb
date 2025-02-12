class ThoughtsController < ApplicationController
  before_action :require_user
  before_action :set_thought, only: [:edit, :update, :destroy]

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

  def show
    @thought = Thought.find(params[:id])
    #render json: @thought
  end

  # ✅ Add Edit Action
  def edit
    @thought = Thought.find(params[:id])
  end
  

  # ✅ Add Update Action
  def update
    if @thought.update(thought_params)
      redirect_to thoughts_path, notice: "Thought updated successfully!"
    else
      flash[:alert] = "Failed to update thought."
      render :edit
    end
  end

  # ✅ Add Destroy Action
  def destroy
    @thought = current_user.thoughts.find(params[:id])
    if @thought.destroy
      flash[:notice] = "Thought was successfully deleted."
    else
      flash[:alert] = "Something went wrong. Could not delete the thought."
    end
    redirect_to thoughts_path
  end
  

  #def destroy
    #if @thought.destroy
      #flash[:notice] = "Thought was successfully deleted."
      #redirect_to thoughts_path
    #else
      #flash[:alert] = "Something went wrong. Could not delete the thought."
      #redirect_to thought_path(@thought)
    #end
  #end


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

  def set_thought
    @thought = current_user.thoughts.find(params[:id]) # Ensures users can edit only their thoughts
    unless current_user == @thought.user || current_user.admin?
      redirect_to thoughts_path, alert: "You are not authorized to delete this thought."
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to thoughts_path, alert: "Thought not found."
  end

  def thought_params
    params.require(:thought).permit(:content)
  end
end
