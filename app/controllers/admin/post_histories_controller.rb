class Admin::PostHistoriesController < ApplicationController
  def index
    @user = EndUser.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Posthistrory.find(params[:id]).destroy
  end
end
