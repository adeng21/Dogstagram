class CreateBarks < ActiveRecord::Migration
  def change
    create_table :barks do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
    add_index :barks, [:post_id, :user_id], unique: true
  end
end
