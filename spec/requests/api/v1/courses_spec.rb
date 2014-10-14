require 'spec_helper'

describe "Courses API" do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    @course = FactoryGirl.create(:course)
  end

  describe "GET /courses (index)" do
    context "with valid parameters" do

      before do
        get('/api/v1/courses', nil, set_headers.merge(auth_with_user(user)))
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

      it "returns the correct amount of courses" do
        expect(json.count).to eq(1)
      end

    end

  end

  describe "GET /course (show)" do
    context "with valid parameters" do

      before do
        get("/api/v1/courses/#{@course.id}", nil, set_headers.merge(auth_with_user(user)))
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

      it "returns the correct key" do
        expect(json["id"]).to eq(@course.id)
      end

      it "should return all the correct associated nodes" do
        puts json
        expect(json).to have_key('announcements')
        expect(json).to have_key('instructor')
        expect(json).to have_key('capsules')
      end

    end

  end

end
