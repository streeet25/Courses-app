class Hometask < ActiveRecord::Base
	belongs_to :user
	belongs_to :lessons, class_name: 'CourseLesson'

	validates :hometask_text, presence: true 
end
