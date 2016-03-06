class CourseLesson < ActiveRecord::Base
  acts_as_list

  mount_uploader :picture, LessonPictureUploader

  belongs_to :course

  validates :title, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :home_task, presence: true

  scope :sorted, -> { order('course_lessons.position ASC') }
end
