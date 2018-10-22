class Api::V1::AreasController < ApplicationController

  def index
    @area = Area.order("RANDOM()").first
    render json: @area
  end

end
