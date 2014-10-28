class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end

    add_index :departments, :name
  end
end
