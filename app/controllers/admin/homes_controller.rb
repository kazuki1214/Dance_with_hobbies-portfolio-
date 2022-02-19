class Admin::HomesController < ApplicationController

  def top
    @hobbies = Hobby.all
  end
end
