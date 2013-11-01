class BarsController < ApplicationController
  before_filter :authenticate_bar_owner, only: [:buy]

  # GET /bars
  # GET /
  def index
    respond_to do |format|
      format.html { render :index, layout: "application" }
    end
  end

  # POST /bars.json
  def create
    @bar = Bar.new(name: params[:name])

    respond_to do |format|
      if @bar.save
        format.json { render 'bars/bar' }
      else
        format.json { render json: { errors: @bar.errors }, status: :unprocessable_entity }
      end
    end
  end

  # POST /bars/:bar_id/songs.json
  def buy
    bar  = Bar.find(params[:id])
    @song = Song.on_sale.find(params[:song_id])

    respond_to do |format|
      format.json { render 'songs/song' }
    end
  end
end
