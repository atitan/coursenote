class AddCapacityToEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :capacity, :integer, default: 0, null: false
  end
end
