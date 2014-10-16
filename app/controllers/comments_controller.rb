class CommentsController < ApplicationController

  helper_method :resource
  
  def create
    idea = Idea.find(params[:idea_id])
    comment = idea.comments.build(params[:comment])
    comment.user_id = current_user.id
    if comment.save
      # Disabled mailing for now
      # UserMailer.delay.new_comment_notification(comment)
      render json: { success: true, comment: render_to_string(partial: "comments/comment", locals: { comment: comment }) }
    else
      render json: comment.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  def edit
    resource
  end

  def update
    if resource.update_attributes(params[:comment])
      redirect_to idea_path(resource.idea), notice: "Comment updated."
    else
      redirect_to idea_path(resource.idea), notice: "Unable to update comment."
    end
  end

  private

  def resource
    @comment ||= Comment.find(params[:id])
  end

end
