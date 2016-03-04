class AddKickColumnToCourseUsers < ActiveRecord::Migration
  def change
    add_column :course_users, :kick, :boolean, default: false
  end
end
