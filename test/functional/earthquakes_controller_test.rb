require 'test_helper'

class EarthquakesControllerTest < ActionController::TestCase
  
  describe "GET #index" do 
    it "renders the :index view" do 
      get :index
      response.should render_template :index
    end
    
    context "without any params" do 
      it "returns all earthquakes in JSON format"
    end
    
    context "with 'on' params" do 
      it "returns earthquakes on the same day (UTC) as the given unix timestamp" do 
        earthquake = Factory(:earthquake)
        get :index, on: 1364582194
        response.should eq(earthquake)
      end
    end
    
    context "with 'over' params" do 
      it "returns earthquakes since the given unix timestamp"
    end
    
    context "with 'over' params" do 
      it "returns earthquakes with larger magnitude than given magnitude"
    end
    
    context "with 'near' params" do 
      it "returns earthquakes within 5 miles of given latitude and longitude coordinates"
    end
    
    context "with more than one params" do 
      it "returns all earthquakes that pass all params"
    end
  end
end
