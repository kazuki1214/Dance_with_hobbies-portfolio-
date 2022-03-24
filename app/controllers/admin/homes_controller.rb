class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @hobbies = Hobby.page(params[:page])
  end
end
