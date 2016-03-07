class CourseKickController < ApplicationController
  before_filter :authenticate_user!

  def update
  	course.participants << user
    course.course_users.(:kick)
  end

  private

  def course
    @course = Course.find(params[:course_id])
  end

  def user
  	@user = User.find(params[:user_id])
  end
  helper_method :course, :user
end
