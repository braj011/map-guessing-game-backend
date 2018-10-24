class Api::V1::AreasController < ApplicationController

  def index
    @area = Area.order("RANDOM()").limit(12)
    render json: @area
  end

end
