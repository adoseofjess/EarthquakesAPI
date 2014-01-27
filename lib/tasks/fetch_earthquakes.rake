desc "Fetch earthquakes and create in database"
task :fetch_earthquakes => :environment do 
  require 'nokogiri'
  require 'open-uri'
  
  page1 = Nokogiri::HTML(open("http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M1.txt"))
  
  numEntries = page1.css("p").text.split("\n").length - 1 
  page1.css("p").text.split("\n")[2..numEntries].each do |earthquake|
    date = earthquake.split(",")[3..5].join("").delete('""')
    lat = earthquake.split(",")[6]
    lng = earthquake.split(",")[7]
    magnitude = earthquake.split(",")[8]

    if Earthquake.find_by_date(date).nil?
      Earthquake.create(date: date, magnitude: magnitude, latitude: lat, longitude: lng)
    end
  end  
end