class LessonsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :course
  load_and_authorize_resource :lesson, through: :course

  def index
    @lessons = course.lessons.visible
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
end
