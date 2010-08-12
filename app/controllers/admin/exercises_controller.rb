class Admin::ExercisesController < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_authorize
  layout 'admin'

  def index
    @exercises = Exercise.all
    @title = 'Список занятий'
  end

  def new
    @exercise = Exercise.new
    @title = 'Добавление занятия'
  end

  def edit
    @exercise = Exercise.find(params[:id])
    @title = 'Редактирование занятия'
  end

  def create
		@exercise = Exercise.new(params[:exercise])
		@title = 'Добавление занятия'
		respond_to do |format|
  		if @exercise.save
    		flash[:notice] = "Занятие добавлено"
    		format.html { redirect_to(:controller=>'exercises') }
 			else
    		format.html { render :action => "new" }
  		end
		end
  end

  def update
    @exercise = Exercise.find(params[:id])
		@title = 'Редактирование занятия'
		respond_to do |format|
			if @exercise.update_attributes(params[:exercise])
		  	flash[:notice] = 'Занятие изменено'
		  	format.html { redirect_to(:controller=>'exercises') }
			else
		  	format.html { render :action => "edit" }
			end
		end
	end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
		respond_to do |format|
  		format.html { redirect_to(:controller=>'exercises') }
		end
	end
end
