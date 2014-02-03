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
        if params[:since].nil? 
          date = params[:on].to_i
          @earthquakes = @earthquakes.select! {|earthquake| Time.at(earthquake.date.to_i).to_s[0..9] == Time.at(date).to_s[0..9] }
          
        else
          date = params[:on].to_i
          if @earthquakes.length > 0
          @earthquakes = @earthquakes.select {|earthquake| earthquake.date.to_i < date }
          end
        end
      end
      
      if !params[:since].nil? 
        # date_since = Time.at(params[:since].to_i)
        date_since = params[:since].to_i
        # year_month_day = params[:since].split("-").map(&:to_i)
        if @earthquakes.length > 0
          @earthquakes = @earthquakes.select {|earthquake| earthquake.date.to_i > date_since }
        end
      end
      
      if !params[:over].nil? 
        magnitude_given = params[:over] 
        if @earthquakes.length > 0
          @earthquakes = @earthquakes.select {|earthquake| earthquake.magnitude >= params[:over].to_f }
          # p @earthquakes.select {|earthquake| earthquake.magnitude.nil? }
        end
      end
      
      if !params[:near].nil? 
        lat_lng1 = []
        params[:near].gsub(/\s+/, "").split(",").each do |coord|
          lat_lng1.push(coord.to_f)
        end
        if @earthquakes.length > 0
          @earthquakes = @earthquakes.select {|earthquake| 
        lat_lng2 = []       
lat_lng2.push(earthquake.latitude.to_f).push(earthquake.longitude.to_f)
Geocoder::Calculations.distance_between(lat_lng1, lat_lng2) < 5.0
        }
        end
      end
      respond_to do |format|
        format.html
        format.json { render json: @earthquakes }
      end
    end
  end
end
