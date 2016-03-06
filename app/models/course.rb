class Course < ActiveRecord::Base
  belongs_to :user

  has_many :lessons, class_name: 'CourseLesson', dependent: :destroy

  has_many :course_users
  has_many :participants, through: :course_users, source: :user

  scope :recent, -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 20 }

  scope :sorted, -> { order('course_lessons.position ASC') }
  scope :newest_first, -> { order('course_lessons.created_at DESC') }

  mount_uploader :picture, CoursePictureUploader
end
