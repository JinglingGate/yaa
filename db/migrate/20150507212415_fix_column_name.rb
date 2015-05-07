class FixColumnName < ActiveRecord::Migration
  def change
    change_table :pins do |t|
      t.rename :lat, :latitude
      t.rename :long, :longitude
    end
  end
end
