require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders new" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of username and password" do
        post :create, user:{username:"",password:""}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates password is >=6 chars" do
        post :create, user:{username:"1",password:"12345"}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects to goals index" do
        post :create, user:{username:"123",password:"123456"}
        expect(response).to redirect_to(goals_url)
      end

      it "logs in user" do
        post :create, user:{username:"123",password:"123456"}
        expect(session[:session_token]).to eq(User.last.session_token)
      end
    end
  end
end
