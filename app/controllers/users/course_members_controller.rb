class Users::CourseMembersController < Users::BaseController
  def ban
    @course_user = CourseUser.where(course_id: params[:course_id], user_id: params[:user_id]).first
    @course_user.update_attribute(:kick, true) if @course_user
  end

  def unban
    @course_user = CourseUser.where(course_id: params[:course_id], user_id: params[:user_id]).first
    @course_user.update_attribute(:kick, false) if @course_user
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def user
    @user = User.find(params[:user_id])
  end
  helper_method :user
end
