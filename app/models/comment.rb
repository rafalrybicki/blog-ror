class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :articles, optional: true

  validates :comment, presence: true
  validates :article_id, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true }
end
