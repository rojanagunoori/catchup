class CommentsController < ApplicationController
  before_action :require_user

  def create
    @thought = Thought.find(params[:thought_id])
    @comment = @thought.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to thoughts_path, notice: "Comment added!"
    else
      redirect_to thoughts_path, alert: "Failed to add comment."
    end
  end

  def like
    @comment = Comment.find(params[:id])
    #like = @comment.likes.find_by(user: current_user)
    like = Like.find_by(user: current_user, comment: @comment)

    if like
      like.destroy
      @comment.update(likes_count: @comment.likes.count)
    else
      Like.create(user: current_user, comment: @comment, comment_id: @comment.id) # ✅ Ensure comment_id is set
      @comment.likes.create(user: current_user)
      @comment.update(likes_count: @comment.likes.count)
    end

    redirect_to thoughts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
