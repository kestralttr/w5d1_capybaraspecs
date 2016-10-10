require 'spec_helper'
require 'rails_helper'

# include ::RSpec::Rails::ControllerExampleGroup

feature "the signup process" do
  before :each do
    visit new_user_path
  end

  scenario "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  scenario "it takes a username and password" do
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      sign_up("han_solo")
      expect(page).to have_content "han_solo"
      expect(current_path).to eq(goals_path)
    end

  end

end

feature "logging in" do
  before(:each) do
    User.create(username:"han_solo",password:"chewie")
  end

  scenario "shows username on the homepage after login" do
    sign_in("han_solo")
    expect(page).to have_content "han_solo"
    expect(current_path).to eq(goals_path)
  end


end

feature "logging out" do
  before(:each) do
    visit new_session_path
    User.create(username:"han_solo",password:"chewie")
  end

  scenario "begins with a logged out state" do
    visit new_session_path
    expect(page).to_not have_content "han_solo"
  end

  scenario "doesn't show username on the homepage after logout" do
    sign_in("han_solo")
    click_button "Logout"
    expect(page).to_not have_content("han_solo")
  end

end
