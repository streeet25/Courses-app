class AddPositionToLessons < ActiveRecord::Migration
  def up
    change_column :course_lessons, :position, :integer

    change_column :course_lessons, :position, :integer, null: false
  end

  def down
    remove_column :course_lessons, :position, :integer
  end
end
