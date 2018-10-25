class Api::V1::AreasController < ApplicationController

  def index
    @areas = Area.order("RANDOM()").uniq(&:constituency).first(10)
    render json: @areas
  end

end
