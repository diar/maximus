class AlbumsController < ApplicationController
  before_filter :init_page

  def index
    @albums=Album.visible
  end

  def show
    @album=Album.find(params[:id])
    @photos = Photo.paginate(:all,
      :conditions   => ['album_id  = ?', params[:id]],
      :page   => params[:page])
  end
end