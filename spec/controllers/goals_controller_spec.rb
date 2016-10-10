require 'spec_helper'
require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:han_solo) { User.create!(username: "han_solo", password: "chewie") }
  before(:each) do
    allow(controller).to receive(:current_user) { han_solo }
  end

  describe "GET \#new" do
    it "renders new session template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST \#create" do
    context "with empty body field" do
      it "re-renders the new goals form and flashes errors" do
        post :create, goal: {body:""}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid body" do
      it "redirects to goal show page" do
        post :create, goal: {body:"ase"}
        expect(response).to redirect_to(goal_url(Goal.last))
      end
    end
  end


  describe "PATCH \#update" do
    before(:each) do
      Goal.create(body:"hi")
    end

    context "with empty body field" do
      it "re-renders the edit goals form and flashes errors" do
        patch :update, goal: {body:""}, id: Goal.last.id
        expect(response).to render_template("edit")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid body" do
      it "redirects to goal show page" do
        patch :update, goal: {body:"ase"}, id: Goal.last.id
        expect(response).to redirect_to(goal_url(Goal.last))
      end
    end
  end

end
