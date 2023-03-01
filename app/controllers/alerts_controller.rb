class AlertsController < ApplicationController

  def create
    request_body = JSON.parse request.body.string
    @incoming_alert = Alert.create(name: request_body["Name"], record_type: request_body["RecordType"],
                                alert_type: request_body["Type"], record_type: request_body["TypeCode"],
                                tag: request_body["Tag"], message_stream: request_body["MessageStream"],
                                description: request_body["Description"], email: request_body["Email"],
                                from: request_body["From"], bounced_at: request_body["BouncedAt"])

    @incoming_alert.notify_slack
    render json: @incoming_alert, status: :created
  end
end