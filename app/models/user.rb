class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
         :presence => true,
         length: {
            maximum: 1,
            tokenizer: lambda { |str| str.split(/\s+/) },
            too_long: "must have only one word"
          },
         :uniqueness => {
           :case_sensitive => false
         }
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
end
