files = ['E', 'EC', 'N', 'NW', 'SE', 'SW', 'W', 'WC']

puts 'Beginning seed, please stand by.'

files.each_with_index do |file, index|

  path = __dir__ + "/csvs/#{file}_postcodes.csv"

  puts "Now seeding #{file} postcodes [#{index+1}/#{files.length}]" 

  CSV.foreach(path, :headers => true) do |row|
    selected_attrs = row.to_hash.slice("postcode", "latitude", "longitude", "district", "ward", "constituency")
    Area.create!(selected_attrs)
  end

end