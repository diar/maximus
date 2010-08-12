class ScheduleController < ApplicationController
  before_filter :init_page
  
  def index
    @exercises = Exercise.all
  end
end