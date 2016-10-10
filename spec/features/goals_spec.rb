require 'spec_helper'
require 'rails_helper'

feature "making new goals" do
  before :each do
    sign_up("han_solo")
    visit new_goal_path
  end

  scenario "has a new goal page" do
    expect(page).to have_content "Create Goal"
  end

  scenario "it takes a body" do
    expect(page).to have_content "Body"
  end

  feature "creating a goal" do

    scenario "shows the goal page after creating goal" do
      create_goal_and_dreams("go to the moon")
      expect(page).to have_content "go to the moon"
      expect(current_path).to eq(goal_path(Goal.last))
    end

  end

  feature "editing goals" do
    before :each do
      create_goal_and_dreams("shit goal")
      click_link 'Edit Goal'
    end

    scenario "has a edit goal page" do
      expect(page).to have_content "Edit Goal"
    end

    scenario "it takes a body" do
      expect(page).to have_content "Body"
    end

    feature "editing a goal" do

      scenario "shows the goal page after editing goal" do
        edit_goal_and_dreams("go to the moon")
        expect(page).to have_content "go to the moon"
        expect(current_path).to eq(goal_path(Goal.last))
      end

    end

  end

end
