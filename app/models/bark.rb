class Bark < ActiveRecord::Base
  belongs_to :user,
    inverse_of: :barks

  belongs_to :post,
    inverse_of: :barks

  validates :user, presence: true
  validates :post, presence: true
  validates :post_id, uniqueness: {scope: :user_id}
end
