class User < ActiveRecord::Base
  resourcify

  rolify

  include Omniauthable

  after_create :create_user_profile

  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_one :profile, dependent: :destroy
  has_many :authored_courses, class_name: 'Course', foreign_key: :user_id
  has_many :social_profiles
  has_many :course_users, dependent: :destroy
  has_many :participated_courses, through: :course_users, source: :course

  accepts_nested_attributes_for :profile

  delegate :first_name, :last_name, to: :profile, allow_nil: true

  def participate_in?(course)
    course_users.exists?(course_id: course.id)
  end

  def banned_in?(course)
    course_users.where(kick: true).exists?(course_id: course.id)
  end

  private

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def create_user_profile
    build_profile
    profile.save(validates: false)
  end
end
