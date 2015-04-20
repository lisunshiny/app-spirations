class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :content
      t.integer :user_id, null: false
      t.boolean :private, null: false, default: false
      t.boolean :complete, null: false, default: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
