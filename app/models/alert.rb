class Alert < ApplicationRecord
  def notify_slack
    if self.alert_type == "SpamNotification"
      SlackNotificationJob.perform_later("New spam notification for #{self.email}")
    end
  end
end
