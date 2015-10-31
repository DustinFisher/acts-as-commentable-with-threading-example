class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @beer = Beer.find(beer_params[:beer_id])
    @body = body
    @user_who_commented = current_user
    @comment = Comment.build_from(@beer, @user_who_commented.id, @body)
    @comment.save
    make_child_comment

    respond_to do |format|
      format.html  { redirect_to(beer_path(@beer),
                     :notice => 'Comment was successfully added.') }
    end
  end

  private

  def beer_params
    params.require(:comment).permit(:body, :beer_id, :comment_id)
  end

  def comment_id
    beer_params[:comment_id]
  end

  def body
    beer_params[:body]
  end

  def make_child_comment
    return "" if comment_id.blank?

    parent_comment = Comment.find comment_id
    @comment.move_to_child_of(parent_comment)
  end

end
