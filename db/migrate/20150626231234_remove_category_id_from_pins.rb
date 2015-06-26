class RemoveCategoryIdFromPins < ActiveRecord::Migration
  def change
    remove_column :pins, :category_id, :integer
  end
end
