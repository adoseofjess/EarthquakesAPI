class CreateEarthquakes < ActiveRecord::Migration
  def change
    create_table :earthquakes do |t|
      t.float :magnitude
      t.float :latitude
      t.float :longitude
      t.timestamp :date

      t.timestamps
    end
  end
end
