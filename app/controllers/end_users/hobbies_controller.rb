class EndUsers::HobbiesController < ApplicationController
  
  def index
    @hobbies = Hobby.all
  end

  def show
    @hobby = Hobby.find(params[:id])
  end
end
