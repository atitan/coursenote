class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer :course_id
      t.integer :term

      t.timestamps
    end

    add_index :terms, :course_id
    add_index :terms, :term
  end
end
