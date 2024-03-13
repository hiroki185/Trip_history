module NotificationsHelper
    def transition_path(notification)
    case notification.action_type.to_sym
    when :commented_to_own_travel
      travel_path(notification.subject.travel, anchor: "comment-#{notification.subject.id}")
    when :favorited_to_own_travel
      travel_path(notification.subject.travel)
    when :followed_me
      user_path(notification.subject.follower)
    end
  end
end
