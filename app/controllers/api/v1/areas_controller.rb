class Api::V1::AreasController < ApplicationController

  def index
    @areas = Area.order("RANDOM()").first(100)
    @areas.uniq(&:constituency).first(10)
    render json: @areas
  end

end
