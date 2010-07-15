class TourController < ApplicationController
  def index
    
  end
  def show
    @room = Room.find_by_uri(params[:id])
    if @room.nil?
      render :text => 'Страница не найдена', :status=>404
    end
  end
end