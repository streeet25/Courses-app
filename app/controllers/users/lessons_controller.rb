class Users::LessonsController < Users::BaseController
  before_action :find_course, :find_lesson, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def show
  end

  def new
    @lesson = find_course.lessons.new
    @lesson_count = find_course.lessons.count + 1
  end

  def create
    @lesson = find_course.lessons.new(lesson_params)

    if @lesson.save
      flash[:success] = 'Lesson was successsfull created.'
      redirect_to users_course_path(@course)
    else
      @lesson_count = @lesson.count + 1
      render :new
    end
  end

  def edit
    @lesson_count = find_course.lessons.count
  end

  def update
    if @lesson.update(lesson_params)
      flash[:success] = 'Lesson was updated.'
      redirect_to users_course_path(find_course)
    else
      @lesson_count = find_lesson.count
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to users_course_path(@course)
  end

  private

  def find_course
    @course = current_user.authored_courses.find(params[:course_id])
  end

  def find_lesson
    @lesson = find_course.lessons.find(params[:id])
  end
  helper_method :find_lesson

  def lesson_params
    params.require(:lesson).permit(:title, :position, :description, :lecture_notes, :picture, :home_task)
  end
end