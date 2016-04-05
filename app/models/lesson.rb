class Lesson < ActiveRecord::Base
  acts_as_list

  mount_uploader :picture, LessonPictureUploader

  belongs_to :course
  has_many :hometasks

  validates :title, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :home_task, presence: true
	validates_format_of :date_of, :with => /\A(?:0?[1-9]|[1-2]\d|3[01])\/(?:0?[1-9]|1[0-2])\/\d{4}\Z/, :message => "^Date must be in the following format: dd/mm/yyyy"

  scope :visible, -> { where(hiden: false) }

  scope :sorted, -> { order('lessons.position ASC') }
end
