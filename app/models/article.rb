class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 3..60 }
  validates :content, presence: true, length: { minimum: 10}
  validates :user_id, presence: true, numericality: { only_integer: true }
end
