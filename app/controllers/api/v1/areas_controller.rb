class Api::V1::AreasController < ApplicationController

  def index
    @area = Area.order("RANDOM()").limit(10)
    render json: @area
  end

end
