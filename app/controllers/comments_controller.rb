class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @beer = Beer.find(beer_params[:beer_id])
    @body = beer_params[:body]
    @user_who_commented = current_user
    @comment = Comment.build_from( @beer, @user_who_commented.id, @body )

    respond_to do |format|
      if @comment.save
        format.html  { redirect_to(beer_path(@beer),
                      :notice => 'Comment was successfully added.') }
      else
        format.html  { render :action => "new" }
      end
    end
  end

  private

  def beer_params
    params.require(:comment).permit(:body, :beer_id)
  end

end
