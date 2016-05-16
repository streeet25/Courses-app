class AddHiddenValueCourseLesson < ActiveRecord::Migration
  def change
    add_column :course_lessons, :hiden, :boolean, default: false
  end
end
