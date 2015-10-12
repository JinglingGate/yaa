class RenameLatLong < ActiveRecord::Migration
  def change
    rename_column :pins, :latitude, :lat
    rename_column :pins, :longitude, :lng
  end
end
