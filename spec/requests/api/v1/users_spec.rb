require 'spec_helper'

describe "Users API" do
  describe "POST /users (create)" do

    context "with valid parameters" do

      before do
        @user_count = User.count

        params = { user:
                    { email: "email@example.com",
                      password: "grapefruit",
                      name: "Damian Mastylo" } }

        post('/api/v1/users',
             params.to_json,
             set_headers)
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

      it "returns the information for the user created" do
        expect(json).to have_key('id')
      end

      it "should create the correct number of users" do
        expect(User.count).to eq(@user_count + 1)
      end

    end

    context "with missing name" do
      before do
        params = { user:
                    { email: "email@example.com",
                      password: "grapefruit" } }

        post('/api/v1/users',
             params.to_json,
             set_headers)
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(400)
      end

      it "should have an error" do
        expect(json).to have_key('name')
        expect(json['name'].first).to eq("can't be blank")
      end
    end

    context "with existing user email" do
      let(:user)  { FactoryGirl.create(:user) }

      before do
        params = { user:
                    { email: user.email,
                      password: "grapefruit",
                      name: user.name } }

        post('/api/v1/users',
             params.to_json,
             set_headers)
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(400)
      end

      it "should have an error" do
        expect(json).to have_key('email')
        expect(json['email'].first).to eq("has already been taken")
      end
    end

  end

  describe "PUT /edit_account (edit)" do
    let(:user)  { FactoryGirl.create(:user) }

    context "with valid parameters" do

      before do
        params = { user:
                    { current_password: "grapefruit",
                      name: "Damian Mastylo" } }

        put('/api/v1/edit_account',
             params.to_json,
             set_headers.merge(auth_with_user(user)))
      end

      it "should be a successful response" do
        expect(response.status).to eq(200)
      end

      it "returns the information for the user edit" do
        expect(json).to have_key('id')
      end

      it "should change the user's name" do
        expect(User.last.name).to eq("Damian Mastylo")
      end

    end

    context "with missing current password" do
      before do
        params = { user:
                    { name: "Damian Mastylo" } }

        put('/api/v1/edit_account',
             params.to_json,
             set_headers.merge(auth_with_user(user)))
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(400)
      end

      it "should have an error" do
        expect(json).to have_key('current_password')
        expect(json['current_password'].first).to eq("can't be blank")
      end
    end

    context "with existing user email" do
      let(:existing_user)  { FactoryGirl.create(:user) }

      before do
        params = { user:
                    { email: existing_user.email,
                      current_password: "grapefruit" } }

        put('/api/v1/edit_account',
             params.to_json,
             set_headers.merge(auth_with_user(user)))
      end

      it "should be a unsuccessful response" do
        expect(response.status).to eq(400)
      end

      it "should have an error" do
        expect(json).to have_key('email')
        expect(json['email'].first).to eq("has already been taken")
      end
    end

  end

end
