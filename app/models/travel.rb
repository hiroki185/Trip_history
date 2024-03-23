class Travel < ApplicationRecord
  belongs_to :user
  
  #いいね機能
  has_many :favorites, dependent: :destroy
  
  #コメント機能
  has_many :travel_comments, dependent: :destroy
  
  #通知機能
  has_one :notification, as: :subject, dependent: :destroy
  
  #画像を扱う
  has_one_attached :image
  
#地図機能の記述
  geocoded_by :address
  after_validation :geocode

#投稿のバリデーション
  validates :category,
    presence: true,
    format: { with: /(?:\A|[\p{Blank}\p{Punctuation}])＃|#/m, message: "は＃を含む必要があります" },
    allow_blank: true
    
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 600 }
  attribute :amount_range, :string
  attribute :transportation, :string
  
#投稿検索の処理
  def self.search(search)
    if search != ""
      Travel.where('title LIKE(?) OR address LIKE(?) OR amount_range LIKE(?) OR transportation LIKE(?) OR category LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%","%#{search}%")
    else
      Travel.all
    end
  end
  
#投稿の並び替えの処理
  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :favorite, -> { joins(:favorites).order("favorites.count DESC") }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end