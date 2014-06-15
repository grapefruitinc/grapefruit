require 'spec_helper'

describe CapsulesController do

  before do
    # Create a new user
    @user = create(:user)
    
    # Login with that user
    visit new_user_session_path
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: "grapefruit"
    click_button "Login"

    # Create a course for this user
    @course = create(:course, instructor: @user)
  end

  describe "capsule creation" do

    # describe "with invalid instructor" do
    #   it "should not allow access" do
    #     expect(page).to have_content 'You are not authorized to access this page.'
    #   end
    # end

    before { visit new_course_capsule_path(@course) }

    describe "with missing fields" do
      it "should not create a capsule" do
        expect { click_button "Add Capsule" }.not_to change(Capsule, :count)
        expect(page).to have_content "Error"
      end
    end

    describe "with valid instructor and all fields filled out" do

      before { fill_in 'capsule_name', with: "Basic Limits" }

      it "should create a capsule" do
        expect { click_button "Add Capsule" }.to change(Capsule, :count).by(1)
      end
    end

  end
end
