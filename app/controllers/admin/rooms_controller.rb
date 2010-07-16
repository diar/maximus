class Admin::RoomsController < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_authorize
  layout 'admin'
  
  def index
    @rooms = Room.all
		@title = 'Список залов'
  end

  def new
    @room = Room.new
    @title = 'Добавление зала'
  end

  def show
    
  end

  def edit
		@room = Room.find(params[:id])
    @room['coord_x'] = ((@room['coord_x'].to_i*728) / 952).to_i - 25;
    @room['coord_y'] = ((@room['coord_y'].to_i*585) / 765).to_i - 25;
		@title = 'Редактирование зала'
	end

  def create
		@room = Room.new(params[:room])
		@title = 'Добавление зала'
		respond_to do |format|
  		if @room.save
    		flash[:notice] = "Зал добавлен"
    		format.html { redirect_to(:controller=>'rooms') }
 			else
    		format.html { render :action => "new" }
  		end
		end
  end

  def update
    @room = Room.find(params[:id])
		@title = 'Редактирование информации о зале'
		respond_to do |format|
      coord_x = params[:room]['coord_x'].to_i;
      coord_y = params[:room]['coord_y'].to_i;
      params[:room]['coord_x'] = ((coord_x*952) / 728).to_i;
      params[:room]['coord_y'] = ((coord_y*765) / 585).to_i;
			if @room.update_attributes(params[:room])
		  	flash[:notice] = 'Информация о зале изменена'
		  	format.html { redirect_to(:controller=>'rooms') }
			else
		  	format.html { render :action => "edit" }
			end
		end
	end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
		respond_to do |format|
  		format.html { redirect_to(:controller=>'rooms') }
		end
	end
  
end