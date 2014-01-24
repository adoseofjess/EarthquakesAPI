class RemoveLatAndLngColumns < ActiveRecord::Migration
  def change
    remove_column :earthquakes, :lat
    remove_column :earthquakes, :lng
  end
end
