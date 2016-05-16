class Users::HometasksController < Users::BaseController
  def index
    @hometasks = lesson.hometasks
    @hometask = lesson.hometasks.build
  end

  def new
    @hometask = lesson.hometasks.build
  end

  def create
    @hometask = lesson.hometasks.build(hometask_params)

    if @hometask.save
      flash[:success] = 'Hometask successfully sent.'
      redirect_to users_course_lesson_hometasks_path
    else
      render :new
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def lesson
    @lesson ||= Lesson.find(params[:lesson_id])
  end
  helper_method :lesson

  def hometask_params
    params.require(:hometask).permit(:name, :hometask)
  end
end
