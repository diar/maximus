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