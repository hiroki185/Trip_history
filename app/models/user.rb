class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :travels, dependent: :destroy #投稿モデル
  has_many :favorites, dependent: :destroy #いいねモデル
  has_one_attached :profile_image #アクティブストレージ(画像を扱う)

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # DM機能
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms

  # コメント機能
  has_many :travel_comments, dependent: :destroy

  # 通知機能
  has_many :notifications, dependent: :destroy

  #
  has_many :view_counts, dependent: :destroy

 #ユーザー情報のバリデーション
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :body, presence: true, length: { maximum: 300 }, allow_blank: true
  validates :name, presence: true, length: { maximum: 15 }


  # ゲストユーザーの処理
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.first_name = "ゲスト"
      user.last_name = "ユーザー"
      user.first_name_kana = "げすと"
      user.last_name_kana = "ゆーざー"
    end
  end

  def guest?
    email == GUEST_USER_EMAIL
  end

#投稿の並び替えの処理
  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :favorite, -> { joins(:favorites).order("favorites.count DESC") }

  def full_name
    first_name + '' + last_name
  end

  def full_name_kana
    first_name_kana + '' + last_name_kana
  end

  def user_status
    if is_deleted == true
      "退会"
    else
      "有効"
    end
  end

  def favorite_travels
    Travel.joins(:favorites).where(favorites: { user_id: self.id })
  end

  # 退会機能
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end

#ユーザー検索の処理
def self.search(search)
  if search.present?
    User.where('name LIKE ?', "%#{search}%")
  else
    User.all
  end
end

# 管理者検索の処理
def self.admin_search(search)
  if search.present?
    User.where('name LIKE ? OR last_name LIKE ? OR first_name LIKE ? OR last_name_kana LIKE ? OR first_name_kana LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  else
    User.all
  end
end


  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # 画像を扱う処理
  def get_profile_image
    profile_image.attached? ? profile_image : 'Untitled_logo_1_free-file.jpg'
  end
end