class FormController < ApplicationController
  def index
    if params[:on].nil? && params[:since].nil? && params[:over].nil? && params[:near].nil?
      @earthquakes = Earthquake.all
            respond_to do |format|
        format.html
        format.json { render json: @earthquakes }
      end
    else 
      @earthquakes = Earthquake.all
      
      if params[:on].length != 0 
        if params[:since].length != 0
          @earthquakes = @earthquakes.select! {|earthquake| Time.at(earthquake.date.to_i).to_s[0..9] == params[:on] }
          
        else
          year_month_day = params[:on].split("-").map(&:to_i)
          date = DateTime.new(year_month_day[0], year_month_day[1], year_month_day[2]).to_i
          if @earthquakes.length > 0
          @earthquakes = @earthquakes.select {|earthquake| earthquake.date.to_i < date }
          end
        end
      end
      
      if params[:since].length != 0
        year_month_day = params[:since].split("-").map(&:to_i)
        date_since = DateTime.new(year_month_day[0], year_month_day[1], year_month_day[2]).to_i
        
        if @earthquakes.length > 0
          @earthquakes = @earthquakes.select {|earthquake| earthquake.date.to_i > date_since }
        end
      end
      
      if params[:over].length != 0
        magnitude_given = params[:over] 
        if @earthquakes.length > 0
          @earthquakes = @earthquakes.select {|earthquake| earthquake.magnitude >= params[:over].to_f }
        end
      end
      
      if params[:near].length != 0
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
