require 'spec_helper'

feature "user deletes a meow for a post", %q{
  As a user
  I want to delete my bark for a post
  So that I can undo my bark if it was an accident
} do

  #ACCEPTANCE CRITERIA
  #I must be signed in to delete a bark
  #I can't delete a bark for a post that I haven't barked
  #When I delete a bark, I should see the bark count go down for the post

  let(:user) {FactoryGirl.create(:user)}
  let!(:post) {FactoryGirl.create(:post)}

  scenario "user deletes bark for a post on the root page" do
    FactoryGirl.create(:bark, user: user, post: post)
    sign_in_as(user)
    visit root_path

    click_on "Remove Bark"

    expect(page).to have_content "0 Barks"
    expect(page).to have_content "All evidence of your barking has been destroyed!"
  end

  scenario "user does not see button to remove bark from post that they have not barked" do
    visit root_path
    expect(page).to_not have_content "Remove Bark"
  end
end
