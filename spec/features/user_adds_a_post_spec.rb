require 'spec_helper'

feature "user adds a post", %q{
  As a user
  I want to make a post
  So that I can share my doggy love with the world
} do

  #ACCEPTANCE CRITERIA
  # I must be logged in
  # I must supply an image
  # I must upload an image from my computer
  # I can optionally leave a tweet-length description

  scenario "user adds a post with valid attributes" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_post_path
    attach_file 'Image', File.join(Rails.root, '/spec/fixtures/sleeping_dog.jpeg')
    fill_in "Description", with: "Sleeping dog"
    click_on "Create Post"

    expect(page).to have_content "Post created successfully."
  end

  scenario "user adds a post with invalid attributes" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_post_path
    click_on "Create Post"

    expect(page).to have_content "There were some errors with your Post."
  end
end
