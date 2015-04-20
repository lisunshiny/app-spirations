require 'spec_helper'
require 'rails_helper'

##bad params, in signup



feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      create_user_bobby
      expect(page).to have_content "bobby"
    end

    it "fails informatively with invalid params" do
      create_bad_user
      expect(page).to have_content("Username can't be blank")
      expect(page).to have_content("Password is too short")
    end
  end
end


feature "logging in" do
  before(:each) do
    create_user_bobby
    logout_user
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
    logout_user
    expect(page).not_to have_content("bobby")
  end


end
