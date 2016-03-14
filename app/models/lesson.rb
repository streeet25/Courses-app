class Lesson < ActiveRecord::Base
  acts_as_list

  mount_uploader :picture, LessonPictureUploader

  belongs_to :course
  has_many :hometasks

  validates :title, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :home_task, presence: true

  scope :sorted, -> { order('lessons.position ASC') }
end
