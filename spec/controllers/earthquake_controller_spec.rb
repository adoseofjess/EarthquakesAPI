require 'spec_helper'

describe EarthquakesController do  
  render_views

    
  describe "GET #index" do 
    before(:all) do
      @recent_earthquake = FactoryGirl.create(:recent_date)
      @not_as_recent_earthquake = FactoryGirl.create(:not_as_recent_date)
      @large_magnitude_earthquake = FactoryGirl.create(:large_magnitude)
      @small_magnitude_earthquake = FactoryGirl.create(:small_magnitude)
      @lat_lng1_earthquake = FactoryGirl.create(:lat_lng1)
      @lat_lng2_earthquake = FactoryGirl.create(:lat_lng2)
      @all_params_earthquake = FactoryGirl.create(:all_params)      
    end
    
    context "without any params" do 
      it "renders the index template" do 
        visit "/earthquakes"
        page.should have_content("Listing Earthquakes")
      end
    end
    
    context "with 'on' params" do 
      it "returns earthquakes on the same day (UTC) as the given unix timestamp" do 
 
        get :index, :on => @recent_earthquake.date.to_i, :format => :json
        parsed_body = JSON.parse(response.body)
        parsed_body[0]["date"].to_datetime.to_i.should eq(@recent_earthquake.date.to_i)
      end
    end
    
    context "with 'since' params" do 
      it "returns earthquakes since the given unix timestamp" do 
        get :index, :since => @not_as_recent_earthquake.date.to_i, :format => :json
        parsed_body = JSON.parse(response.body)
        parsed_body[0]["date"].to_datetime.to_i.should be >= @not_as_recent_earthquake.date.to_i
      end
    end
    
    context "with 'over' params" do 
      it "returns earthquakes with larger magnitude than given magnitude" do
        get :index, :over => @small_magnitude_earthquake.magnitude, :format => :json
        parsed_body = JSON.parse(response.body)
        parsed_body[0]["magnitude"].should be >= @small_magnitude_earthquake.magnitude
      end
    end
    
    context "with 'near' params" do 
      it "returns earthquakes within 5 miles of given latitude and longitude coordinates" do 
      get :index, :near => "34.0352,-116.4138", :format => :json
      parsed_body = JSON.parse(response.body)
      
      (parsed_body[0]["latitude"]-34).should be < 1
      (parsed_body[0]["longitude"]-(-116)).should be < 1
      end
    end
   
    after(:all) do 
     @recent_earthquake.delete
     @not_as_recent_earthquake.delete
     @large_magnitude_earthquake.delete
     @small_magnitude_earthquake.delete
     @lat_lng1_earthquake.delete
     @lat_lng2_earthquake.delete
     @all_params_earthquake.delete
   end 
  end
end
