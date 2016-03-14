class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def update
    course.participants << current_user
  end

  def destroy
    course.course_users.where(user_id: current_user).first.destroy
  end

  def kick
    course_user = CourseUser.where(course_id: params[:course_id], user_id: params[:user_id]).first

    course_user.update_attribute(:kick, true) if course_user
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def user
    @user = User.find(params[:user_id])
  end

  helper_method :course
end
