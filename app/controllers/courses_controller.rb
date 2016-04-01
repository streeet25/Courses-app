class CoursesController < ApplicationController
  PER_PAGE = 3

  def index
    @courses = Course.recent.visible.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  private

  def course
    @course ||= Course.find(params[:id])
  end
  helper_method :course
end
