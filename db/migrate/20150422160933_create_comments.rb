class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :body
      t.integer :commentable_id
      t.string :commentable_type
      t.timestamps null: false
    end

    add_index :comments, :commentable_id
  end
end
