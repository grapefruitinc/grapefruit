require 'spec_helper'

describe "Capsules" do
  describe "GET /capsules" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get capsules_index_path
      response.status.should be(200)
    end
  end
end
