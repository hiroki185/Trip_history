class Travel < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :travel_comments, dependent: :destroy

  #通知機能
  has_many :notifications, dependent: :destroy
  
  has_one_attached :image
  
#タグについてのバリデーション
validates :category,
  presence: true,
  format: { with:/(?:\A|[\p{Blank}\p{Punctuation}])＃|#/m, message: "は＃を含む必要があります" },
  allow_blank: true
#投稿名のバリデーション  
validates :title, presence: true

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

#いいねした投稿の並び替え
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :favorite, -> { joins(:favorites).order("favorites.count DESC") }

#フォロー機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
