class ApplicationController < ActionController::API

  def serialize(items)
    ActiveModelSerializers::SerializableResource.new(items).as_json
  end

end
