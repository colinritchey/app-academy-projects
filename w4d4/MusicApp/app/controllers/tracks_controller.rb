class TracksController < ApplicationController
  before_action :regester_user!

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = ["Invalid input of track"]
      render :new
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    render :edit
  end

  def update
    @track = Track.find_by(id: params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = ["Invalid input of track"]
      render :edit
    end
  end

  def index
    @tracks = Track.all
    render :index
  end

  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    current_album = @track.album
    if @track.destroy
      redirect_to album_url(current_album)
    else
      flash[:errors] = ["Couldn't delete"]
      redirect_to track_url(@track)
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :bonus, :lyrics)
  end
end
