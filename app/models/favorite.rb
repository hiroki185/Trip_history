class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :travel

  validates :user_id, uniqueness: {scope: :travel_id}
  
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications
  
    private
  def create_notifications
    Notification.create(subject: self, user: self.travel.user, action_type: :favorited_to_own_travel)
  end
end
