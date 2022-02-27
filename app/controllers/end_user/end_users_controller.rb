class EndUser::EndUsersController < ApplicationController
  
  def show
    @user = EndUser.find(params[:id])
  end
  
  def edit
  end
  
  def update
  end
  
  def withdraw
  end
  
end
