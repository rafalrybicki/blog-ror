class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, length: { in: 3..60 }
  validates :content, presence: true, length: { minimum: 10}
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :category_id, presence: true
  validate :correct_image

  def self.search(params)
    articles = Article.where("title ILIKE ? or content ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
    articles
  end

  def correct_image
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/jpg image/png))
      errors.add(:image, 'must be a JPEG, JPG or PNG')
    elsif image.attached? == false
      errors.add(:image, 'is required')
    elsif image.byte_size > 1.megabytes
      errors.add(:image, "musnt not be larger than 1MB")
    end

  end
end
