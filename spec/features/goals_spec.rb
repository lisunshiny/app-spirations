require 'spec_helper'
require 'rails_helper'



feature "viewing goals" do
  it "forces users to log in before viewing goals" do
    visit goals_url
    expect(page).to_not have_content("Goals")
  end

  it "doesn't display private goals" do
    create_user_bobby
    create_goal_private
    logout_user
    create_user_hank
    expect(page).to_not have_content("Eat more veggies")
  end

  it "has an index with all viewable goals" do
    create_user_bobby
    create_goal_private
    create_goal_public

    visit goals_url
    expect(page).to have_content("Eat more veggies")
    expect(page).to have_content("Eat less meat")
  end
end

feature "creating a goal" do
  before(:each) do
    create_user_bobby
  end

  it "has a new goal page" do
    visit new_goal_url
    expect(page).to have_content("New Goal")
  end

  it "shows goal on user's page after creation" do
    create_goal_public
    expect(page).to have_content("Eat less meat")
  end

  it "doesn't make a new goal with invalid data" do
    create_bad_goal
    expect(page).to have_content("Title can't be blank")
  end
end

feature "editing a goal" do
  before(:each) do
    create_user_bobby
    create_goal_public
  end
  it "defaults to incomplete" do
    expect(page).to have_content("In progress")
  end

  it "shows as complete once changed" do
    click_on("Complete")
    expect(page).to have_content("Completed")
  end

  it "does not permit editing if user is not owner" do
    logout_user
    create_user_hank
    visit user_url(User.first)
    expect(page).to_not have_content("Complete")
  end
end
