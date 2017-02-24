class AlbumsController < ApplicationController
  before_action :regester_user!

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = ["Invalid input of album"]
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    render :edit
  end

  def update
    @album = Album.find_by(id: params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = ["Invalid input of album"]
      render :edit
    end
  end

  def index
    @albums = Album.all
    render :index
  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    current_band = @album.band
    if @album.destroy
      redirect_to band_url(current_band)
    else
      flash[:errors] = ["Couldn't delete"]
      redirect_to album_url(@album)
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :studio)
  end
end
