class Admin::AlbumsController < ApplicationController
  before_filter :admin_authorize
  layout 'admin'
  def index
    @albums = Album.all
		@title = 'Список альбомов'
	end

	def new
		@album = Album.new
		@title = 'Добавить альбом'
	end

	def edit
		@album = Album.find(params[:id])
		@title = 'Редактирование альбома'
	end

  def show
    @album = Album.find(params[:id])
		@title = 'Просмотр альбома'
	end

	def create
		@album = Album.new(params[:album])
		@title = 'Добавить альбом'
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
    @album = Album.find(params[:id])
		@title = 'Редактирование альбома'
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
    @album = Album.find(params[:id])
    @album.destroy
		respond_to do |format|
  		format.html { redirect_to(admin_albums_url) }
		end
	end
end