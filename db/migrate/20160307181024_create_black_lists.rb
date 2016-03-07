class CreateBlackLists < ActiveRecord::Migration
  def change
    create_table :black_lists do |t|
    	t.integer :user_id
    	t.integer :course_id

      t.timestamps null: false
    end

    add_index :black_lists, [:user_id, :course_id], unique: true
  end
end
