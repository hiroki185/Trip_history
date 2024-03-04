class Travel < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_one_attached :image

    attribute :amount_range, :string
    attribute :transportation, :string

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
