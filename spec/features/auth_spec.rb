require 'spec_helper'
require 'rails_helper'


feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', with: "bob"
      fill_in 'password', with: "bobbob"
      click_on "Create User"

      expect(page).to have_content "bob"
    end
  end
end

feature "logging in" do
  create_user_bobby
  logout_user_bobby

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
