class Api::V1::ImagesController < ApplicationController

  def index
  end

  def show
    filename = params[:id]
    send_file "public/maps/#{filename}.png", type: 'image/png', disposition: 'inline'
  end

end
