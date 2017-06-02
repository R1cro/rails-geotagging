require "rails_helper"

RSpec.describe API::SessionsController, type: [:controller, :api] do

  describe "POST #login" do
    context "with valid email and password" do
      before :all do
        pass = "12345678"
        @user = create(:user, password: pass)
        post api_login_path, user: { email: @user.email, password: pass }, format: :json
      end

      it "should return new token of located user" do
        @user.reload
        expect(last_response.body["user"]).to be_present
        expect(JSON.parse(last_response.body)["user"]["auth_token"]).to eq @user.auth_token
        expect(JSON.parse(last_response.body)["user"]["id"]).to eq @user.id
      end

      it "should have a success http status" do
        expect(last_response.status).to eq 200
      end

    end

    context "with incorrect params" do
      before do
        user = create(:user)
        post api_login_path, user: { email: user.email, password: nil }, format: :json
      end

      it "should assign user as nil" do
        expect(assigns[:user]).to be_nil
      end

      it "should have an unauthorized http status" do
        expect(last_response.status).to eq 401
      end
    end
  end

  describe "DELETE #logout" do

    context "unauthenticated" do
      it "should require user authentication via token" do
        delete api_logout_path
        expect(assigns[:current_user]).to eq nil
        expect(JSON.parse(last_response.body)["error"]).to eq "Access denied. Your token is invalidated or expired."
        expect(last_response.status).to eq 401
      end
    end

    context "Authenticated" do
      before do
        @user = create(:user)
        sign_in(@user)
      end

      it "should set current user to nil" do
        delete api_logout_path
        expect(assigns[:current_user]).to eq nil
      end
    end

  end

end
