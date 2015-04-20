require 'spec_helper'
require 'rails_helper'



feature "make comments on goals" do

  scenario "can make comments from goal page" do
    create_goal_comment
    expect(page).to have_content("that is some hippie nonsense")
  end

  scenario "invalid comments fail informatively" do
    create_bad_goal_comment
    expect(page).to have_content("Body can't be blank")
  end

  scenario "cannot make comment unless logged in" do
    create_user_bobby
    create_comment_public
    logout_user

    visit goal_url(Goal.first)

    expect(page).to have_content("Username")
  end


end




feature "Make comments on users" do

  scenario "can comment from user page" do
    create_user_comment
    expect(page).to have_content("good luck")
  end

  scenario "invalid comment fails informatively" do
    create_bad_user_comment
    expect(page).to have_content("Body can't be blank")
  end

  scenario "cannot make comment unless logged in" do
    create_user_bobby
    logout_user
    visit user_url(User.first)
    expect(page).to have_content("Username")

  end

end
