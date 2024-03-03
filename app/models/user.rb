class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

     has_many :travels, dependent: :destroy
     has_many :favorites, dependent: :destroy
     has_one_attached :profile_image

     validates :first_name, presence: true
     validates :last_name, presence: true
     validates :last_name_kana, presence: true
     validates :first_name_kana, presence: true

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'Untitled_logo_1_free-file.jpg'
  end

end
