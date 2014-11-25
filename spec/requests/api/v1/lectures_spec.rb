require 'spec_helper'

describe "Lectures API" do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    # @course = FactoryGirl.create(:course)
    # @capsule = FactoryGirl.create(:capsule, course: @course)
    @lecture = FactoryGirl.create(:lecture)
  end

  describe "GET /courses/id/capsules/id (show)" do
    context "with valid parameters" do

      before do
        get("/api/v1/courses/#{@lecture.capsule.course.id}/capsules/#{@lecture.capsule.id}/lectures/#{@lecture.id}", nil, set_headers.merge(auth_with_user(user)))
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

      it "returns the correct key" do
        expect(json["id"]).to eq(@lecture.id)
      end

      it "should return all the correct associated nodes" do
        expect(json).to have_key('documents')
        expect(json).to have_key('videos')
        expect(json).to have_key('comments')
      end

    end

  end

end
