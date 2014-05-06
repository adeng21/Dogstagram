require 'spec_helper'

feature 'user creates a bark for a post', %q{
  As a user
  I want to create a bark for a post
  So that I can tell others that I like the post
} do

  #ACCEPTANCE CRITERIA
  #I must be signed in to bark at a post
  #I should see the current bark count
  #When I bark, I should see the bark count go up
  #I cannot Bark at the same Post twice

  let!(:post) {FactoryGirl.create(:post)}

  context "as an authenticated user" do
    before(:each) do
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      visit root_path
    end

    scenario "user creates a Bark for a Post" do
      click_button "Bark"

      expect(page).to have_content "1 Bark"
      expect(page).to have_content "We hear you Bark!"
    end

    scenario "user cannot Bark a second time at a Post" do
      click_button "Bark"

      expect(page).to_not have_button "Bark", exact: true
    end
  end

  scenario "unauthenticated user cannot create a Bark" do
    visit root_path

    expect(page).to_not have_button "Bark"
  end
end
