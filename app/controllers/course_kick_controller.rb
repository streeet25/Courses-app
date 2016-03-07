class CourseKickController < ApplicationController
  before_filter :authenticate_user!

  def update
    course.course_users.update
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
