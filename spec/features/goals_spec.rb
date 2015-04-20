require 'spec_helper'
require 'rails_helper'


feature "creating a goal" do

  it "has a new goal page" do
    visit new_goal_url
    expect(page).to have_content("New Goal")
  end

  it "shows goal on user's page after creation" do
      create_user_bobby
      create_goal
      expect(page).to have_content
  end
end

feature "logging in" do
  before(:each) do
    create_user_bobby
    logout_user_bobby
  end

  it "shows username on the homepage after login" do
    login_user_bobby
    expect(page).to have_content 'bobby'
  end
end

feature "logging out" do


  it "begins with logged out state" do
    visit goals_url
    expect(page).to have_content("Sign Up")
  end

  it "doesn't show username on the homepage after logout" do
    create_user_bobby
    logout_user_bobby
    expect(page).not_to have_content("bobby")
  end


end
