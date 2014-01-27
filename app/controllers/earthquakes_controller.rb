class EarthquakesController < ApplicationController
  def index
    
    if params[:on].nil? && params[:since].nil? && params[:over].nil? && params[:near].nil?
      @earthquakes = Earthquake.all
            respond_to do |format|
        format.html
        format.json { render json: @earthquakes }
      end
    
    else 
      @earthquakes = Earthquake.all
      
      if !params[:on].nil? 
        # date = Time.at(params[:on].to_i)
        if params[:since].nil?
          p @earthquakes.length
          @earthquakes = @earthquakes.select! {|earthquake| earthquake.date.to_i == params[:on].to_i }
          p @earthquakes.length
        else
          p params[:on].to_i
          p @earthquakes.first.date.to_i
          @earthquakes = @earthquakes.select! {|earthquake| earthquake.date.to_i < params[:on].to_i }
        end
      end
      
      if !params[:since].nil?
        date_since = Time.at(params[:since].to_i)
        # @earthquakes = Earthquake.where("date > :date_since", date_since: date_since)
        @earthquakes = @earthquakes.select {|earthquake| earthquake.date.to_i > params[:since].to_i }
      end
      
      if !params[:over].nil? && params[:over].to_s.length != 0
        magnitude_given = params[:over] 
        # @earthquakes = Earthquake.where("magnitude >= :magnitude_given", magnitude_given: magnitude_given)
        @earthquakes = @earthquakes.select {|earthquake| earthquake.magnitude >= params[:over].to_i }
      end
      
      if !params[:near].nil? && params[:near].length != 0
        lat_lng1 = []
        params[:near].gsub(/\s+/, "").split(",").each do |coord|
          lat_lng1.push(coord.to_f)
        end
        @earthquakes.select! {|earthquake| 
        lat_lng2 = []       
lat_lng2.push(earthquake.latitude.to_f).push(earthquake.longitude.to_f)
Geocoder::Calculations.distance_between(lat_lng1, lat_lng2) < 5.0
        }
      end
      respond_to do |format|
        format.html
        format.json { render json: @earthquakes }
      end
    end
  end
end
