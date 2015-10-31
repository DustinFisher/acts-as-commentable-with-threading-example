class BeersController < ApplicationController
  before_action :authenticate_user!

  def show
    @beer           = Beer.find(params[:id])
    @comment_count  = @beer.comment_threads.count == 0 ? "no" : @beer.comment_threads.count
    @comment        = Comment.new
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html  { redirect_to(beer_path(@beer),
                      :notice => 'The beer was successfully added.') }
      else
        format.html  { render :action => "new" }
      end
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :description)
  end
end
