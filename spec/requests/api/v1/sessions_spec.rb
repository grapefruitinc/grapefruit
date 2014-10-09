require 'spec_helper'

describe "Sessions API" do
  let(:user)  { FactoryGirl.create(:user) }

  describe "POST /sign_in (create)" do

    context "with valid parameters" do

      before do
        params = { user:
                    { email: user.email,
                      password: "foobarbaz" } }

        post('/api/v1/sign_in',
             params.to_json,
             set_headers)
      end

      it "returns the information for the user created" do
        expect(json).to have_key('id')
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

    end

    context "with wrong password" do
      before do
        params = { user:
                    { email: user.email,
                      password: "wrongpassword" } }

        post('/api/v1/sign_in',
             params.to_json,
             set_headers)
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(401)
      end

      it "should have an error" do
        expect(json['success']).to eq(false)
      end

      it "should describe the error" do
        expect(json['message']).to eq("Incorrect password")
      end
    end

  end

  describe "DELETE /sign_out (delete)" do

    context "with authentication token" do

      before do
        delete('/api/v1/sign_out',
             nil,
             set_headers.merge(auth_with_user(user)))
      end

      it "returns the information for the user created" do
        expect(json['success']).to eq(true)
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

    end

    context "without authentication token" do
      before do
        delete('/api/v1/sign_out',
             nil,
             set_headers)
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(401)
      end

      it "should have an error" do
        expect(json['success']).to eq(false)
      end

      it "should describe the error" do
        expect(json['message']).to eq("Email is missing.")
      end
    end

  end

end
