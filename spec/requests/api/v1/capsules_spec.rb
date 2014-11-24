require 'spec_helper'

describe "Capsules API" do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    @course = FactoryGirl.create(:course)
    @capsule = FactoryGirl.create(:capsule, course: @course)
  end

  describe "GET /courses/id/capsules (index)" do
    context "with valid parameters" do

      before do
        get("/api/v1/courses/#{@course.id}/capsules", nil, set_headers.merge(auth_with_user(user)))
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

      it "returns the correct amount of capsules" do
        expect(json.count).to eq(1)
      end

    end

  end

  describe "GET /courses/id/capsules/id (show)" do
    context "with valid parameters" do

      before do
        get("/api/v1/courses/#{@course.id}/capsules/#{@capsule.id}", nil, set_headers.merge(auth_with_user(user)))
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

      it "returns the correct key" do
        expect(json["id"]).to eq(@capsule.id)
      end

      it "should return all the correct associated nodes" do
        expect(json).to have_key('lectures')
      end

    end

  end

end
