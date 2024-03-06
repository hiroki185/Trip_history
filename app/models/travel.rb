class Travel < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :travel_comments, dependent: :destroy
  has_one_attached :image

  validates :category, presence: true, allow_blank: true, format: { with: /\A#?(.+)/, message: "は＃（ハッシュタグ）を含むか空である必要があります" }

    attribute :amount_range, :string
    attribute :transportation, :string

#検索条件
  def self.search(search)
    if search != ""
       Travel.where('title LIKE(?) OR address LIKE(?) OR amount_range LIKE(?) OR transportation LIKE(?) OR category LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%","%#{search}%")
    else
      Travel.all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
