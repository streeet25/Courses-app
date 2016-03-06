class CoursesController < ApplicationController
  PER_PAGE = 3

  def index
    @courses = Course.recent.where(hiden: false).page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    @course_lesson = find_course.lessons.where(hiden: false)
  end

  private

  def find_course
    @course = current_user.authored_courses.find(params[:id])
  end
end
