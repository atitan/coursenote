class CreateVersions < ActiveRecord::Migration[4.2]
  def change
    create_table :versions do |t|
      t.string   :item_type, null: false
      t.integer  :item_id,   null: false
      t.string   :event,     null: false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at

      t.integer  :user_id, null: false
      t.integer  :course_id, null: false
      t.integer  :parent_id
    end
    add_index :versions, [:item_type, :item_id]
    add_index :versions, :user_id
    add_index :versions, :course_id
    add_index :versions, :parent_id
  end
end
