class Api::V1::AreasController < ApplicationController

  def index
    @areas = Area.order("RANDOM()").first(100)
    @areas = @areas.uniq(&:constituency).first(10)
    @winner = @areas.sample
    image = Image.new(
      params[:difficulty],
      @winner,
      params[:seed]
      )
    render json: { areas: serialize(@areas), filename: image.filename }
  end

end
