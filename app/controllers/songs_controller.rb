class SongsController < ApplicationController
  # GET /songs.json
  def index
    @songs = Song.paginate(:per_page => params[:limit], :page => params[:page])

    respond_to do |format|
      format.json
    end
  end

  # GET /songs/on_sale.json
  def on_sale
    @songs = Song.on_sale.paginate(:per_page => params[:limit], :page => params[:page])

    respond_to do |format|
      format.json
    end
  end

  # POST /songs.json
  def create
    @song = Song.new(title: params[:title], artist: params[:artist], album: params[:album], price_in_cents: params[:price])

    respond_to do |format|
      if @song.save
        format.json { render 'songs/song' }
      else
        format.json { render json: { errors: @song.errors }, status: :unprocessable_entity }
      end
    end
  end
end
