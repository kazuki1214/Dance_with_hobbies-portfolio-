class EndUsers::PostsController < ApplicationController
  
  def index
    @posts = params[:hobby_id].posts
  end

  def show
    @post = Post.find(params[:])
  end

  def new
  end
  
  def confirm
  end
  
  def create
  end
  
  def destroy
  end
  
end
