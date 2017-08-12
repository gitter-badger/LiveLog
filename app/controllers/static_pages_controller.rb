class StaticPagesController < ApplicationController
  def home
    #
  end

  def stats
    if params[:y]
      start = Date.new(params[:y].to_i, 4, 1)
      range = (start...start + 1.year)
    else
      stop = Date.today
      range = (stop - 1.year..stop)
    end

    @songs = Song.includes(:live).where('lives.date' => range)
    @playings = Playing.includes(song: :live).where('lives.date' => range)
  end
end
