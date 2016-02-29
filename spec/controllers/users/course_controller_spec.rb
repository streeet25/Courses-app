require 'rails_helper'

RSpec.describe Users::CoursesController, type: :controller do

  login_user

  let (:course) { create(:course) }

  describe "Get #index" do

    context "when user logged in" do
      before do
        @courses = double
        @courses.stub_chain(:recent, :page, :per).and_return('example')
        allow(@logged_in_user).to receive(:courses) { @courses }
        get :index
      end

      it "is should return http status succes" do
        expect(response).to have_http_status(:ok)
      end

      it "renders 'index template'" do
        expect(response).to render_template(:index)
      end

      it "assign courses as courses" do
        expect(assigns(:courses)).to eq('example')
      end
    end

    context "when user is logged out" do
      before do
        get :index
      end
      it "redirect to sign_in path" do
        expect {should redirect_to new_user_session}
      end
      it "render warning" do
        expect { should set_the_flash(:warning).to('You need to sign in or sign up before continuing.') }
      end
    end
  end

  describe "Get #new" do
    it "is should return http status succes" do
      @courses = double(:build => "example")
      allow(@logged_in_user).to receive(:courses) { @courses }
      get :new
      expect(response).to have_http_status(:ok)
    end

    it "assigns new rating to @ratings" do
      @courses = double(:build => "example")
      allow(@logged_in_user).to receive(:courses) { @courses }
      get :new
      expect(assigns(:course)).to eq("example")
    end
  end

  describe "POST 'create'" do
    context "when rating was created" do
      before do
        allow(@logged_in_user).to receive(:courses) { @courses }
        @course = double(:save => true)
        @courses = double(:build => @course)
      end

      it 'should redirect to course_path' do
        do_request_course
        expect(response).to redirect_to(users_courses_path)
      end
    end

    context "when rating wasn't created" do

      before do
        allow(@logged_in_user).to receive(:courses) { @courses }
        @course = double(:save => false)
        @courses = double(:build => @course)
      end

      it 'should render new' do
        do_request_course
        get :new
        expect(response).to render_template(:new)
      end
    end

    def do_request_course
      post :create, { :course =>  { :title => 'example'  }}
    end
  end

  describe "post 'edit'" do

    before do
      @courses = double
      allow(@logged_in_user).to receive(:courses) { @courses }
      allow(@courses).to receive(:find) { course }
    end

    it "is should return http status succes" do
      get :edit, :id => course.id
      expect(response).to have_http_status(:ok)
    end

    it 'should assigns item to instance variable' do
      get :edit, :id => course.id
      expect(assigns(:course)).to eq(course)
    end
  end

  describe "put 'update'"  do

    before do
      @courses = double
      allow(@logged_in_user).to receive(:courses) { @courses }
      allow(@courses).to receive(:find) { course }
    end

    it 'should assigns course to instance variable' do
      do_request
      expect(assigns(:course)).to eq(course)
    end

    context "when course was updated" do
      before do
        allow(course).to receive(:update) { true }
      end

      it 'should redirect to courses_path' do
        do_request
        expect(response).to redirect_to(users_courses_path)
      end
    end

    context "when course wasn't updated" do

      before do
        allow(course).to receive(:update) { false }
      end

      it 'should render new' do
        do_request
        expect(response).to render_template(:edit)
      end
    end

    def do_request
      put :update, { :id => course.id,  :course => { :title => 'example' }}
    end
  end

  describe "delete 'destroy'" do

    before do
      @courses = double
      allow(@logged_in_user).to receive(:courses) { @courses }
      allow(@courses).to receive(:find) { course }
    end

    it 'should assigns course to instance variable' do
      do_request
      expect(assigns(:course)).to eq(course)
    end

    context "when course was destroyed" do
      before do
        allow(course).to receive(:destroy) { true }
      end
    end

    it 'should redirect to courses_path' do
      do_request
      expect(response).to redirect_to(users_courses_path)
    end

    def do_request
      delete :destroy, { :id => course.id }
    end
  end
end