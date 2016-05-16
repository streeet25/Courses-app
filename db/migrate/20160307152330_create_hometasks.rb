class CreateHometasks < ActiveRecord::Migration
  def change
    create_table :hometasks do |t|
      t.string :name
      t.text :hometask
      t.integer :lesson_id, null: false
    end

    add_index :hometasks, :lesson_id
  end
end
