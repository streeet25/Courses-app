class CreateCourseLessons < ActiveRecord::Migration
  def change
    create_table :course_lessons do |t|
    	t.string  :title
    	t.integer :position
    	t.string  :description
    	t.string  :lecture_notes
    	t.string  :picture
    	t.string  :home_task
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
