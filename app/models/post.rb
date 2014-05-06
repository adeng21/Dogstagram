class Post < ActiveRecord::Base
  belongs_to :user,
  inverse_of: :posts

  has_many :barks,
    dependent: :destroy,
    inverse_of: :post

  validates :user, presence: true
  validates :image, presence: true
  validates :description, length: {maximum: 140}

  mount_uploader :image, PostImageUploader

  def self.by_recency
    order(created_at: :desc)
  end

  def has_bark_from?(user)
    barks.find_by(user_id: user.id).present?
  end

  def bark_from(user)
    barks.find_by(user_id: user.id)
  end
end


