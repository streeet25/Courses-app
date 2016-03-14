class ChangeColumnNameCourseLessonToLesson < ActiveRecord::Migration
  def self.up
    rename_table :course_lessons, :lessons
  end

  def self.down
    rename_table :course_lessons, :lessons
  end
end
