class CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.new(comment_params)
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to self.send(show_url, comment_params[:commentable_id])
  end

  def destroy
    @comment = Comment.find_by(comment_params)
    @comment.destroy
    redirect_to goals_url
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end

    def show_url
      path = comment_params[:commentable_type].downcase
      "#{path}_url".to_sym
    end


end
