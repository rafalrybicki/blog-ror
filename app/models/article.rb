class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { in: 3..60 }
  validates :content, presence: true, length: { minimum: 10}
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :category_id, presence: true

  def self.search(params)
    articles = Article.where("title ILIKE ? or content ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
    articles
  end
end
