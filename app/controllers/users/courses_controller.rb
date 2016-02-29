class Users::CoursesController < Users::BaseController
  PER_PAGE = 3

  before_action :find_course, only: [:edit, :update, :destroy]

  def index
    @courses = current_user.courses.recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(courses_params)

    if @course.save
      redirect_to users_courses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(courses_params)
      redirect_to users_courses_path
    else
      render :edit
    end
  end

  def destroy
    @course.destroy

    redirect_to users_courses_path
  end

  private

  def find_course
    @course = current_user.courses.find(params[:id])
  end

  def courses_params
    params.require(:course).permit(:title, :picture)
  end
end
