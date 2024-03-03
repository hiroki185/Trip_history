class Travel < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_one_attached :image
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
