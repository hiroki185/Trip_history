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

     has_many :user_rooms, dependent: :destroy
     has_many :chats, dependent: :destroy
     has_many :rooms, through: :user_rooms

     validates :first_name, presence: true
     validates :last_name, presence: true
     validates :last_name_kana, presence: true
     validates :first_name_kana, presence: true

     #ゲストユーザーの処理
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

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'Untitled_logo_1_free-file.jpg'
  end
end
