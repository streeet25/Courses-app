class Users::CoursesController < Users::BaseController
  before_filter :load_course, except: :index
  before_action :my_courses, only: :index

  PER_PAGE = 3

  before_action :find_course, only: [:edit, :update, :show, :destroy]

  def index
    my_courses.sort! { |a, b| a.updated_at <=> b.updated_at }
    @paginatable_array = Kaminari.paginate_array(my_courses).page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def new
    @course = current_user.authored_courses.build
  end

  def create
    @course = current_user.authored_courses.build(courses_params)

    if @course.save
      redirect_to users_courses_path
    else
      render :new
      flash[:error] = 'You dont have rights to create course.'
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

  def show
    @lessons = find_course.lessons.sorted.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def destroy
    @course.destroy

    redirect_to users_courses_path
  end

  private

  def my_courses
    @courses = current_user.authored_courses + current_user.participated_courses
  end

  def find_course
    @course = Course.find(params[:id])
  end
  helper_method :find_course

  def courses_params
    params.require(:course).permit(:title, :picture, :hiden)
  end

  def load_course
    redirect_to root_path, alert: 'Not authorized as an trainer.' unless current_user.has_role? :trainer
  end
end
