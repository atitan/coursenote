class AddCapacityToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :capacity, :integer, default: 0, null: false
  end
end
