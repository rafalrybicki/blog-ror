 class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, length: { in: 3..60 }
  validates :content, presence: true, length: { minimum: 10}
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :category_id, presence: true
  validates :image, attached: true,
                    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                    aspect_ratio: :landscape,
                    size: { less_than: 1.megabytes , message: 'must be smaller than 1MB' }

  def self.search(params)
    articles = Article.where("title ILIKE ? or content ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
    articles
  end

  def card_img
    self.image.variant(resize: '360X240')
  end

  def article_img
    self.image.variant(resize: '900')
  end
end
