class Api::V1::ImagesController < ApplicationController

  def show
    filename = params[:id]
    send_file "tmp/#{filename}.png", type: 'image/png', disposition: 'inline'
  end

end
