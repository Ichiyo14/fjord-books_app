# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]
  before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t(:notice_create, scope: 'controllers.common', name: Comment.model_name.human)
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, notice: t(:notice_destroy, scope: 'controllers.common', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
