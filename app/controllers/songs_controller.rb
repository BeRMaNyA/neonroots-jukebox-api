class SongsController < ApplicationController
  # GET /songs
  def songs
    @songs = Song.paginate(:per_page => 50, :page => params[:page])

    respond_to do |format|
      format.html
    end
  end
end
