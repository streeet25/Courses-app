class Users::LessonsController < Users::BaseController

	before_action :find_course

	def new 
		@lesson = @course.lessons.new
	end

	def create
		@lesson = @course.lessons.new(lesson_params)

		if @lesson.save
			flash[:success] = "Lesson was successsfull created."
			redirect_to users_course_path(@course)
		else
			render :new
		end
	end

	def edit
		@lesson = @course.lessons.find(params[:id])
	end

	def update
		@lesson = @course.lessons.find(params[:id])

		if @lesson.update(lesson_params)
			flash[:success] = "Lesson was updated."
			redirect_to users_course_path(find_course)
		else 
			render :edit
		end
	end

	def destroy
		@lesson = @course.lessons.find(params[:id])
		redirect_to users_course_path(@course)
	end


	private

	def find_course
		@course = current_user.authored_courses.find(params[:course_id])
	end

	def lesson_params
		params.require(:course_lesson).permit(:title, :position, :description, :lecture_notes, :picture, :home_task)
	end
end
