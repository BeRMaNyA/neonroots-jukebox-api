class BarsController < ApplicationController
  # GET /bars
  # GET /
  def index
    respond_to do |format|
      format.html { render :index, layout: "application" }
    end
  end

  # POST /bars
  def create
    @bar = Bar.new(name: params[:name])

    respond_to do |format|
      if @bar.save
        format.html { render 'bars/bar' }
      else
        format.html { render json: { errors: @bar.errors }, status: :unprocessable_entity }
      end
    end
  end

  # POST /bars/:bar_id/songs
  def buy
  end
end
