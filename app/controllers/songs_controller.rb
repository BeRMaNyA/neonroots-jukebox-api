class SongsController < ApplicationController
  # GET /songs
  def index
    @songs = Song.paginate(:per_page => 50, :page => params[:page])

    respond_to do |format|
      format.html
    end
  end

  # GET /songs/on_sale
  def on_sale
    @songs = Song.on_sale.paginate(:per_page => 50, :page => params[:page])

    respond_to do |format|
      format.html
    end
  end

  # POST /songs
  def create
    @song = Song.new(title: params[:title], artist: params[:artist], album: params[:album], price_in_cents: params[:price])

    respond_to do |format|
      if @song.save
        format.html { render 'songs/song' }
      else
        format.html { render json: { errors: @song.errors }, status: :unprocessable_entity }
      end
    end
  end
end
