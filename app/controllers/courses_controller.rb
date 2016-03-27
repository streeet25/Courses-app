class CoursesController < ApplicationController
  before_filter :load_lesson, only: :show
  authorize_resource only: :show
  PER_PAGE = 3

  def index
    @courses = Course.recent.visible.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
  end

  private

  def course
    @course = Course.find(params[:id])
  end
  helper_method :course

  def find_lesson
    @lesson = course.lessons
  end

  def load_lesson
    @lessons = find_lesson.where(hiden: false)
  end
end
