class AlbumsController < ApplicationController
  def index
    @albums=Album.visible
  end

  def show
    @album=Album.find(params[:id])
  end
end