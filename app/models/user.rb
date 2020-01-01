class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :username,
         :presence => true,
         length: {
           maximum: 20,
           message: 'must have maximum 20 characters'
         },
         format: {
           without: /\s/,
           message: 'must have only one word'
         },
         :uniqueness => {
           :case_sensitive => false
         }
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
end
