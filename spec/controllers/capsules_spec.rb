require 'spec_helper'

describe CapsulesController do

  include Devise::TestHelpers
  let(:current_user) { create(:user) }
  let(:course) { create(:course) }
  before { sign_in current_user }

  describe "GET #show" do

    it "finds the requested capsule" do
      capsule = create(:capsule, course: course)
      get :show, { course_id: course, id: capsule }
      assigns(:capsule).should eq(capsule)
    end

    it "renders the :show view" do
      capsule = create(:capsule, course: course)
      get :show, { course_id: course, id: capsule }
      response.should render_template :show
    end

  end

end
