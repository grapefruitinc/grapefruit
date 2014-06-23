require 'spec_helper'

describe AdminController do

  describe "GET 'become'" do
    it "returns http success" do
      get 'become'
      response.should be_success
    end
  end

end
