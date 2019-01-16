class Image

  @@base_url = 'https://maps.googleapis.com/maps/api/staticmap?size=480x480&center='
  @@api_key = ENV['GOOGLE_API']

  attr_reader :filename

  def initialize(difficulty, winner, seed)
    mask = "%05d" % (seed.to_i * winner.id)
    @filename = "#{Time.now.to_i}#{mask}"
    @difficulty = difficulty
    @lat = winner.latitude
    @lon = winner.longitude
    data = open(self.google_url)
    IO.copy_stream(data, "tmp/#{@filename}.png")
  end

  def google_url
    "#{@@base_url}#{@lat},#{@lon}&zoom=#{self.zoom}&key=#{@@api_key}#{self.styling}"
  end

  def zoom
    case @difficulty
      when "easy"
        "15"
      when "medium"
        "15"
      when "hard"
        "17"
    end
  end

  def styling
    visibility = @difficulty == "easy" ? "on" : "off"

    "&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0xebe3cd&style=element:labels.text.fill%7Ccolor:0x523735&style=element:labels.text.stroke%7Ccolor:0xf5f1e6&style=feature:administrative%7Celement:geometry.stroke%7Ccolor:0xc9b2a6&style=feature:administrative.land_parcel%7Celement:geometry.stroke%7Ccolor:0xdcd2be&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xae9e90&style=feature:administrative.locality%7Celement:labels.text%7Cvisibility:off&style=feature:administrative.neighborhood%7Celement:labels.text%7Cvisibility:off&style=feature:landscape.natural%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:poi%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x93817c&style=feature:poi.business%7Celement:labels%7Cvisibility:#{visibility}&style=feature:poi.park%7Celement:geometry.fill%7Ccolor:0xa5b076&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x447530&style=feature:poi.place_of_worship%7Celement:labels%7Cvisibility:#{visibility}&style=feature:poi.school%7Celement:labels.text%7Cvisibility:#{visibility}&style=feature:road%7Celement:geometry%7Ccolor:0xf5f1e6&style=feature:road.arterial%7Celement:geometry%7Ccolor:0xfdfcf8&style=feature:road.highway%7Celement:geometry%7Ccolor:0xf8c967&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0xe9bc62&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0xe98d58&style=feature:road.highway.controlled_access%7Celement:geometry.stroke%7Ccolor:0xdb8555&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x806b63&style=feature:transit.line%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:transit.line%7Celement:labels.text.fill%7Ccolor:0x8f7d77&style=feature:transit.line%7Celement:labels.text.stroke%7Ccolor:0xebe3cd&style=feature:transit.station%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:transit.station.rail%7Celement:labels.text%7Cvisibility:#{visibility}&style=feature:water%7Celement:geometry.fill%7Ccolor:0xb9d3c2&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x92998d"
  end 

end
