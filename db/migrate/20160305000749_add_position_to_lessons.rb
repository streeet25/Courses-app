class AddPositionToLessons < ActiveRecord::Migration
  def up
    change_column :course_lessons, :position, :integer

    # не забудьте задать порядок
    CourseLesson.order('id desc').each.with_index do |item, position|
      item.update_attribute :position, position
    end

    change_column :course_lessons, :position, :integer, null: false
  end

  def down
    remove_column :course_lessons, :position, :integer
  end
end
