class AreaSerializer < ActiveModel::Serializer
  attributes :id, :postcode, :latitude, :longitude,
             :district, :constituency
end
