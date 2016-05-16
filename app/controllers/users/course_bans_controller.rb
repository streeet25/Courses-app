class Users::CourseBansController < Users::BaseController
  before_action :ban_user

  def create
    ban_user.update_attribute(:kick, true) if @course_user
  end

  def destroy
    ban_user.update_attribute(:kick, false) if @course_user
  end

  private

  def course
    @course ||= current_user.authored_courses.find(params[:course_id])
  end
  helper_method :course

  def user
    @user ||= User.find(params[:user_id])
  end
  helper_method :user

  def ban_user
    @course_user = CourseUser.where(course_id: params[:course_id], user_id: params[:user_id]).first
  end
end
