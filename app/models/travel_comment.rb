class TravelComment < ApplicationRecord
belongs_to :user
belongs_to :travel

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private
  def create_notifications
    Notification.create(subject: self, user: travel.user, action_type: :commented_to_own_travel)
  end
end
