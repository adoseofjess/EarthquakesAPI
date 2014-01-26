class EarthquakesController < ApplicationController
  def index

    
    
    
    if params[:on].nil? && params[:since].nil? && params[:over].nil? && params[:near].nil?
      @earthquakes = Earthquake.all
      
      # render :json => @earthquakes
      respond_to do |format|
        format.html
        format.json { render json: @earthquakes }
      end
      
    else 
      @earthquakes = Earthquake.all
      if !params[:on].nil?
        date = Time.at(params[:on].to_i)
        @earthquakes = Earthquake.find_all_by_date(date)
      end
      if !params[:since].nil?
        date_since = Time.at(params[:since].to_i)
        @earthquakes = Earthquake.where("date > :date_since", date_since: date_since)
      end
      if !params[:over].nil?
        magnitude_given = params[:over] 
        @earthquakes = Earthquake.where("magnitude >= :magnitude_given", magnitude_given: magnitude_given)
      end
      if !params[:near].nil?
        lat_lng1 = []
        params[:near].split(",").each do |coord|
          lat_lng1.push(coord.to_f)
        end
        @earthquakes.select! {|earthquake| 
        lat_lng2 = []       
lat_lng2.push(earthquake.latitude.to_f).push(earthquake.longitude.to_f)
Geocoder::Calculations.distance_between(lat_lng1, lat_lng2) < 5.0
        }
      end
      # render :json => @earthquakes
      respond_to do |format|
        format.html
        format.json { render json: @earthquakes }
      end
    end
  end
end
