class CoursesController < ApplicationController
  PER_PAGE = 3

  def index
    @courses = Course.recent.where(hiden: false).page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    @lessons = find_lesson.where(hiden: false)
  end

  private

  def find_course
    @course = Course.find(params[:id])
  end
  helper_method :find_course

  def find_lesson
    @lesson = find_course.lessons
  end
end
