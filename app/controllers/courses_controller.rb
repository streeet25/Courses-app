class CoursesController < ApplicationController
  PER_PAGE = 3
  before_filter :lesson_acces, only: :show

  def index
    @courses = Course.recent.visible.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    @lessons = find_lesson.where(hiden: false)
  end

  private

  def course
    @course = Course.find(params[:id])
  end
  helper_method :course

  def find_lesson
    @lesson = course.lessons
  end

  def lesson_acces
    redirect_to root_path, alert: 'Acces denied.' unless current_user.participate_in?(course) && !current_user.banned_in?(course)
  end
end
