class CourseKickController < ApplicationController
	before_filter :authenticate_user!

  def destroy
    course.course_users.first.destroy
    respond_to do |format|
  		format.js {render inline: "location.reload();" }
		end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
