class Api::V1::User::SubscriptionsController < Api::V1::User::ProfilesController
  before_filter :authenticate_user!
  before_action :deny_access, only: [:create, :destroy] if :banned?

  def index
    participated_courses = current_user.participated_courses
    respond_with_success(participated_courses)
  end

  def create
    course.subscribers << current_user

    render json: { success: true, message: 'Successfully subscribed!' }, status: 201
  end

  def destroy
    authorize! :unsubscribe, @course
    course.course_users.find_by(user_id: current_user.id).destroy!

    render json: { success: true, message: 'Successfully unsubscribed!' }, status: 202
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def deny_access
    redirect_to root_path, notice: 'You are banned.'
  end

  def banned?
    current_user.course_users.where(kick: true).exists?(course_id: course.id)
  end
end