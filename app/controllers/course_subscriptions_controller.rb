class CourseSubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    if current_user.course_users.where(kick: true).exists?(course_id: course.id)
      flash[:error] = 'You are banned.'
    else
      course.participants << current_user
    end
  end

  def destroy
    if current_user.course_users.where(kick: true).exists?(course_id: course.id)
      flash[:error] = 'You are banned.'
    else
      course.course_users.where(user_id: current_user).first.destroy
    end
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
