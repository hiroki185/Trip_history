class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  has_one :notification, as: :subject, dependent: :destroy

  def guest?
    email == GUEST_USER_EMAIL
    # もしくは以下のように一致するかどうかを判定する方法もあります
    # email.downcase == GUEST_USER_EMAIL.downcase
    # ただし、大文字と小文字の違いを無視して判定する場合にのみ使用してください
  end

  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, user: followed, action_type: :followed_me)
  end
end
