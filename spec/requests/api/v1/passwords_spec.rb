require 'spec_helper'

describe "Passwords API" do
  let(:user) { FactoryGirl.create(:user) }

  describe "POST /forgot_password (create)" do

    context "with valid parameters" do

      before do
        params = { user:
                    { email: user.email } }

        post('/api/v1/forgot_password', params.to_json, set_headers)
      end

      it "returns the information for the user created" do
        expect(json).to have_key('email')
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

    end

    context "with nonexistent email" do
      before do
        params = { user:
                    { email: "meowtestemail@meow.com" } }

        post('/api/v1/forgot_password', params.to_json, set_headers)
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(400)
      end

      it "should have an error" do
        expect(json['success']).to eq(false)
      end

      it "should describe the error" do
        expect(json['message']).to eq("Email does not exist in our records, please try again.")
      end
    end

  end

  describe "PUT /change_password (put)" do

    context "with correct reset_password_token" do
      let(:user_forgot_password) { FactoryGirl.create(:user_forgot_password) }

      before do
        params = { user:
                    { password: "testpassword",
                      password_confirmation: "testpassword",
                      reset_password_token: user_forgot_password.name }}

        put('/api/v1/change_password', params.to_json, set_headers)
      end

      it "returns the information for the user created" do
        expect(json).to have_key('authentication_token')
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

    end

    context "with unrequested user" do
      before do
        params = { user:
                    { password: "testpassword",
                      password_confirmation: "testpassword",
                      reset_password_token: "incorrect_token" } }

        put('/api/v1/change_password', params.to_json, set_headers)
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(400)
      end

      it "should have an error" do
        expect(json).to have_key("reset_password_token")
      end

      it "should describe the error" do
        expect(json['reset_password_token'].first).to eq("is invalid")
      end
    end

    context "without incorrect reset_password_token" do
      before do
        params = { user:
                    { email: user.email } }

        post('/api/v1/forgot_password', params.to_json, set_headers)

        params = { user:
                    { password: "testpassword",
                      password_confirmation: "testpassword",
                      reset_password_token: "incorrect_token" }}

        put('/api/v1/change_password', params.to_json, set_headers)
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(400)
      end

      it "should have an error" do
        expect(json).to have_key('reset_password_token')
      end

      it "should describe the error" do
        expect(json['reset_password_token'].first).to eq("is invalid")
      end
    end

  end

end
