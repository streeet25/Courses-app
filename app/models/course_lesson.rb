class CourseLesson < ActiveRecord::Base
	acts_as_sortable
	mount_uploader :picture, LessonPictureUploader

	belongs_to :course

	validates :title, presence: true, length: { maximum: 20 }
	validates :description, presence: true, length: { maximum: 100 }
	validates :home_task, presence: true

end
