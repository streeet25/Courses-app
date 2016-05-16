class Course < ActiveRecord::Base
  resourcify

  belongs_to :user

  has_many :lessons, dependent: :destroy

  has_many :course_users, dependent: :destroy
  has_many :participants, through: :course_users, source: :user

  scope :recent, -> { order(created_at: :desc) }

  scope :visible, -> { where(hiden: false) }

  validates :title, presence: true, length: { maximum: 20 }

  scope :sorted, -> { order('lessons.position ASC') }
  scope :newest_first, -> { order('lessons.created_at DESC') }

  mount_uploader :picture, CoursePictureUploader

  def participate_in?(course)
    course_users.exists?(course_id: course.id)
  end
end
