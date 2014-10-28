class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end

    add_index :teachers, :name
  end
end
