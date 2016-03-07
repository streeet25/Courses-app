class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def update
    course.participants << current_user
  end

  def destroy
    course.course_users.where(user_id: current_user).first.destroy
  end

  def update_opinion
   course.course_users.where(user_id: course_users.id).update(:kick, true)
   redirect_to :back
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  
  helper_method :course
end
