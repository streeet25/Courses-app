class CreateHometasks < ActiveRecord::Migration
  def change
    create_table :hometasks do |t|
    	t.text :hometask_text, null: false
    	t.integer :user_id
    	t.integer :course_lesson_id

      t.timestamps null: false
    end

    add_index :hometasks, [:user_id, :course_lesson_id]
  end
end
