class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  enum action_type: { commented_to_own_travel: 0, favorited_to_own_travel: 1, followed_me: 3}
end
