class CoursesController < ApplicationController
  
  PER_PAGE = 3
  
  def index
    @courses = Course.recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    
    if @course.save
      flash[:success] = "Course created."
      redirect_to courses_path
    else
      flash[:error] = "Course wasn't created."
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    
    if @course.update_attributes(course_params)
      flash[:success] = "Courses updated."
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:success] = "Course deleted."
    
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :picture)
  end
end
