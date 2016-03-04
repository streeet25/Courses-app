class ChangePositionValue < ActiveRecord::Migration
  def change
  	change_column :course_lessons, :position, :integer, null: false
  	add_index :course_lessons, [:position]
  end
end
