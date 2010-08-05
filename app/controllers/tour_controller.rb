class TourController < ApplicationController
  before_filter :init_page

  def index
    @rooms = Room.all
  end
  def show
    @room = Room.find_by_uri(params[:id])
    if @room.nil?
      render :text => 'Страница не найдена', :status=>404
    end
  end
end