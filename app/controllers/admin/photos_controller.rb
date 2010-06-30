class Admin::PhotosController < ApplicationController
  before_filter :admin_authorize
  layout "admin"

	def new
    # Работа с контентом
		@photo = Photo.new
    @album = Album.find(params[:album_id])
    # Настройка страницы
		@title = 'Добавить фотографию'
    # Отображение страницы
		respond_to do |format|
  		format.html
		end
	end

	def edit
    # Работа с контентом
		@photo = Photo.find(params[:id])
    # Настройка страницы
		@title = 'Редактирование фотографии'
    # Отображение страницы
		respond_to do |format|
  		format.html
		end
	end

	def show
    # Работа с контентом
    @photo = Photo.find(params[:id])
    # Настройка страницы
		@title = 'Просмотр фотографии'
    # Отображение страницы
		respond_to do |format|
  		format.html
		end
	end

	def create
    # Работа с контентом
		@photo = Photo.new(params[:photo])
    @album = Album.find(params[:album_id])
    @photo.album_id = @album.id
    # Настройка страницы
		@title = 'Добавить фотографию'
    # Отображение страницы
		respond_to do |format|
  		if @photo.save
    		flash[:notice] = "Фотография добавлена"
    		format.html { redirect_to(:controller=>'albums', :action=>'show',:id=>@album.id) }
 			else
    		format.html { render :action => "new" }
  		end
		end
	end

	def update
    # Работа с контентом
    @photo = Photo.find(params[:id])
    # Настройка страницы
		@title = 'Редактирование фотографии'
    # Отображение страницы
		respond_to do |format|
			if @photo.update_attributes(params[:photo])
		  	flash[:notice] = 'Фотография изменена'
		  	format.html { redirect_to(:controller=>'albums', :action=>'show',:id=>@photo.album_id) }
			else
		  	format.html { render :action => "edit" }
			end
		end
	end

	def destroy
    # Работа с контентом
    @photo = Photo.find(params[:id])
    album_id = @photo.album_id
    @photo.destroy
    # Отображение страницы
		respond_to do |format|
  		format.html { redirect_to(:controller=>'albums', :action=>'show',:id=>album_id) }
		end
	end
end
