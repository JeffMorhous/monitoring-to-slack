class SlackNotificationJob < ApplicationJob

  def perform(message)
    return unless ENV['SLACK_ENDPOINT'].present?

    HTTParty.post(
      ENV['SLACK_ENDPOINT'],
      body: {
        text: message
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end