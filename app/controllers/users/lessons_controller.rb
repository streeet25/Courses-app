class Users::LessonsController < Users::BaseController
  before_action :course, :find_lesson, only: [:edit, :update, :destroy]
  authorize_resource

  def index
    @lessons = course.lessons.sorted
  end

  def new
    @lesson = course.lessons.new
    @lesson_count = course.lessons.count + 1
  end

  def create
    @lesson = course.lessons.new(lesson_params)

    if @lesson.save
      flash[:success] = 'Lesson was successsfull created.'
      redirect_to users_course_lessons_path(@course)
    else
      @lesson_count = @lesson.count + 1
      render :new
    end
  end

  def edit
    @lesson_count = course.lessons.count
  end

  def update
    if find_lesson.update(lesson_params)
      flash[:success] = 'Lesson was updated.'
      redirect_to users_course_lessons_path(course)
    else
      @lesson_count = course.lessons.count
      render :edit
    end
  end

  def destroy
    find_lesson.destroy
    redirect_to users_course_lessons_path(course)
  end

  private

  def course
    @course = Course.find(params[:course_id])
  end



  def find_lesson
    @lesson = course.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :position, :description, :lecture_notes, :picture, :home_task, :hiden, :date_of)
  end
end
