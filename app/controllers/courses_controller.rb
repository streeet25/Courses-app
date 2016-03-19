class CoursesController < ApplicationController
  PER_PAGE = 3
  before_filter :lesson_acces, only: :show

  def index
    @courses = Course.recent.hiden.page(params[:page]).per(params[:per_page] || PER_PAGE)
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

  def lesson_acces
    redirect_to root_path, alert: 'Not participated.' unless current_user.course_users.exists?(course_id: find_course.id)
  end
end
