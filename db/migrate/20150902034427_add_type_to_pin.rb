class AddTypeToPin < ActiveRecord::Migration
  def change
    add_column :pins, :aggression_type, :string
  end
end
