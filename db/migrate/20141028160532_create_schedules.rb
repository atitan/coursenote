class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :course_id
      t.integer :day
      t.integer :period

      t.timestamps
    end

    add_index :schedules, :course_id
    add_index :schedules, :day
    add_index :schedules, :period
  end
end
