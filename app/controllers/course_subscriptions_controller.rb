class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :deny_access if :banned?

  def create
    course.participants << current_user
  end

  def destroy
    course.course_users.where(user_id: current_user).first.destroy
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def user
    @user = User.find(params[:user_id])
  end
  helper_method :user

  def deny_access
    redirect_to root_path, notice: 'You are banned.'
  end

  def banned?
    current_user.course_users.where(kick: true).exists?(course_id: course.id)
  end
end
