FactoryGirl.define do 
  factory :earthquake do |f|
    factory :large_magnitude do |f|
      f.magnitude 5.0
    end
    
    factory :small_magnitude do |f|
      f.magnitude 1.0
    end
    
    factory :recent_date do |f|
      f.magnitude 0.0
      f.date "Fri, 24 Jan 2014 23:41:43 UTC +00:00"
    end
    
    factory :not_as_recent_date do |f|
      f.magnitude 0.0
      f.date "Fri, 17 Jan 2014 23:49:14 UTC +00:00"
    end
    
    factory :lat_lng1 do |f|
      f.magnitude 0.0
      f.latitude 34.0352
      f.longitude -116.4138
    end
    
    factory :lat_lng2 do |f|
      f.magnitude 0.0
      f.latitude 100
      f.longitude 100
    end
    
    factory :all_params do |f|
      f.magnitude 5.0
      f.date "Fri, 24 Jan 2014 23:41:43 UTC +00:00"
      f.latitude 34.0352
      f.longitude -116.4138
    end
  end
end


