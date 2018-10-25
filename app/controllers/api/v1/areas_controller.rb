class Api::V1::AreasController < ApplicationController

  def index
    @areas = Area.order("RANDOM()").limit(10)
    render json: @areas
  end

end
