class Travel < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :travel_comments, dependent: :destroy
  has_one :notification, as: :subject, dependent: :destroy
  has_one_attached :image

  geocoded_by :address
  after_validation :geocode

  validates :category,
    presence: true,
    format: { with: /(?:\A|[\p{Blank}\p{Punctuation}])＃|#/m, message: "は＃を含む必要があります" },
    allow_blank: true

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 600 }
  attribute :amount_range, :string
  attribute :transportation, :string

  def self.search(search)
    if search != ""
      Travel.where('title LIKE(?) OR address LIKE(?) OR amount_range LIKE(?) OR transportation LIKE(?) OR category LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%","%#{search}%")
    else
      Travel.all
    end
  end

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :favorite, -> { joins(:favorites).order("favorites.count DESC") }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end