class EarthquakesController < ApplicationController

  
  def index
    if params[:on].nil? && params[:since].nil? && params[:over].nil? && params[:near].nil?
      @earthquakes = Earthquake.all
      render :json => @earthquakes
    else 
      # p params[:near].split(",")
      @earthquakes = Earthquake.all
      if !params[:on].nil?
        date = Time.at(params[:on])
        @earthquakes = Earthquake.find_by_date(date)
      end
      if !params[:since].nil?
        date_since = Time.at(params[:since])
        @earthquakes = Earthquake.where("date > :date_since", date_since: date_since)
      end
      if !params[:over].nil?
        magnitude_given = params[:over] 
        @earthquakes = Earthquake.where("magnitude > :magnitude_given", magnitude_given: magnitude_given)
      end
      if !params[:near].nil?
        lat_lng = params[:near]
        
      end
      render :json => @earthquakes
    end
  end
end
