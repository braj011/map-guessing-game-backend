files = ['E', 'EC', 'N', 'NW', 'SE', 'SW', 'W', 'WC']

ActiveRecord::Base.logger = nil

puts 'Beginning seed, please stand by.'

files.each_with_index do |file, index|

  path = __dir__ + "/csvs/#{file}_postcodes.csv"

  puts "Now seeding #{file} postcodes [#{index+1}/#{files.length}]" 

  count = 1
  CSV.foreach(path, :headers => true) do |row|
    if count == 1 
      selected_attrs = row.to_hash.slice("postcode", "latitude", "longitude", "district", "ward", "constituency")
      Area.create!(selected_attrs)
      count += 1
    elsif count == 15
      count = 1
    else
      count += 1
    end
  end

end