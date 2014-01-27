require 'spec_helper'
require 'rake'

describe 'fetch_earthquakes' do 
  before :all do 
    @rake = Rake::Application.new
    Rake.application = @rake
    load Rails.root + "lib/tasks/fetch_earthquakes.rake"
    Rake::Task.define_task(:environment)
  end
  
  describe 'fetching' do 
    it "should have 'environment' as a prereq" do 
      @rake["fetch_earthquakes"].prerequisites.should include("environment")
    end
    
    it "should fetch earthquakes" do 
      @rake["fetch_earthquakes"].invoke
      expect(Earthquake.all.length).to be > 0
    end
  end
end