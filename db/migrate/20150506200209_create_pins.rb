class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.belongs_to :user
      t.decimal :lat
      t.decimal :long
      t.timestamps #null: false
    end
  end
end
