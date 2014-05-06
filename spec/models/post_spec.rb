require 'spec_helper'

describe Post do
  it {should belong_to :user}
  it {should have_many(:barks).dependent(:destroy)}

  it {should have_valid(:user).when(User.new)}
  it {should_not have_valid(:user).when(nil)}

  it {should_not have_valid(:image).when(nil, "")}

  it {should have_valid(:description).when(nil, "", ("a"*140))}
  it {should_not have_valid(:description).when("a"*141)}
end

describe ".by_recency" do
  it "orders the posts by most recent first" do
    oldest = FactoryGirl.create(:post, created_at: Time.now - 3.days)
    newest = FactoryGirl.create(:post, created_at: Time.now)
    middle = FactoryGirl.create(:post, created_at: Time.now - 2.days)

    expect(Post.by_recency).to eq [newest, middle, oldest]
  end
end

describe "#has_bark_from?" do
  it "returns true if given user has already created a bark for post" do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post)
    bark = FactoryGirl.create(:bark, user: user, post: post)

    expect(post).to have_bark_from user
  end

  it "returns false if given user has not already created a bark for post" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post)
    bark = FactoryGirl.create(:bark, post: post, user: user2)

    expect(post).to_not have_bark_from user
  end
end

describe "#bark_from" do
  context "User has a Bark for a given Post" do
    it "returns that instance of Bark" do
      bark = FactoryGirl.create(:bark)
      post = bark.post
      user = bark.user

      expect(post.bark_from(user)).to eq bark
    end
  end

  context "User doesn't have a Bark for a given Post" do
    it "returns nil" do
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)

      expect(post.bark_from(user)).to eq nil
    end
  end
end
