class CoursesController < ApplicationController
  PER_PAGE = 3

  def index
    @courses = Course.recent.where(hiden: false).page(params[:page]).per(params[:per_page] || PER_PAGE)
  end
end
