class AddHidenBoolleaToCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :hiden, :boolean, default: false
  end
end
