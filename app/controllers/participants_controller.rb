class ParticipantsController < ApplicationController
  def index
    @users = course.participants.includes(:profile)
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
