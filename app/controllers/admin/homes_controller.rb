class Admin::HomesController < ApplicationController

  def top
    @hobbies = Hobby.page(params[:page])
  end
end
