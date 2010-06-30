class Admin::AlbumsController < ApplicationController
  before_filter :admin_authorize
  layout 'admin'
  def index
    # Работа с контентом
    @albums = Album.all
		@title = 'Список альбомов'
    # Отображение страницы
		respond_to do |format|
			format.html
		end
	end

	def new
    # Работа с контентом
		@album = Album.new
    # Настройка страницы
		@title = 'Добавить альбом'
    # Отображение страницы
		respond_to do |format|
  		format.html
		end
	end

	def edit
    # Работа с контентом
		@album = Album.find(params[:id])
    # Настройка страницы
		@title = 'Редактирование альбома'
    # Отображение страницы
		respond_to do |format|
  		format.html
		end
	end

  def show
    # Работа с контентом
    @album = Album.find(params[:id])
    # Настройка страницы
		@title = 'Просмотр альбома'
    # Отображение страницы
		respond_to do |format|
  		format.html
		end
	end

	def create
    # Работа с контентом
		@album = Album.new(params[:album])
    # Настройка страницы
		@title = 'Добавить альбом'
    # Отображение страницы
		respond_to do |format|
  		if @album.save
    		flash[:notice] = "Альбом добавлен"
    		format.html { redirect_to(admin_albums_url) }
 			else
    		format.html { render :action => "new" }
  		end
		end
	end

	def update
    # Работа с контентом
    @album = Album.find(params[:id])
    # Настройка страницы
		@title = 'Редактирование альбома'
    # Отображение страницы
		respond_to do |format|
			if @album.update_attributes(params[:album])
		  	flash[:notice] = 'Альбом изменен'
		  	format.html { redirect_to(admin_albums_url) }
			else
		  	format.html { render :action => "edit" }
			end
		end
	end

	def destroy
    # Работа с контентом
    @album = Album.find(params[:id])
    @album.destroy
    # Отображение страницы
		respond_to do |format|
  		format.html { redirect_to(admin_albums_url) }
		end
	end
end