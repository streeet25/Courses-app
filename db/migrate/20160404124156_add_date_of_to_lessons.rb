class AddDateOfToLessons < ActiveRecord::Migration
  def change
  	add_column :lessons, :date_of, :string
  end
end
