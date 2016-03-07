class Users::HometasksController < Users::BaseController
	def new
    respond_to do |format|
      format.any(:html, :json) 
      format.any { head 404, "content_type" => 'text/plain' }
      format.html { render layout: !request.xhr? }
    end
  end

  def create 
  	@hometask = find_lesson.hometasks.new(hometask_params)

  	if @hometask.save
  		flash[:success] = "Hometask successfully sent."
  		redirect_to users_course_lessons_path
  	else
  		render :new
  	end
  end

  def edit 
  	@hometask = find_lesson.hometasks.find(params[:id])
  end

  def update 
  	@hometask = find_lesson.hometasks.find(params[:id])

  	if @hometask.update(hometask_params)
      flash[:success] = "Hometask updated."
      redirect_to users_course_lessons_path
    else
      render :edit
    end
  end

  def destroy
  	@hometask = find_lesson.hometasks.find(params[:id])
  	@hometask.destroy

    redirect_to users_course_lessons_path
  end

  private

  def find_course
    @course = current_user.authored_courses.find(params[:course_id])
  end

  def find_lesson
    @lesson = find_course.lessons.find(params[:id])
  end

  def hometask_params
    params.require(:hometasks).permit(:hometask_text)
  end
end
