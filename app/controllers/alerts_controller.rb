class AlertsController < ApplicationController

  def create
    request_body = JSON.parse request.body.string
    @incoming_alert = Alert.new(name: request_body["Name"], record_type: request_body["RecordType"],
                                alert_type: request_body["Type"], record_type: request_body["TypeCode"],
                                tag: request_body["Tag"], message_stream: request_body["MessageStream"],
                                description: request_body["Description"], email: request_body["Email"],
                                from: request_body["From"], bounced_at: request_body["BouncedAt"]).save

    # TODO: Parse the alert and decide whether to send to slack
    render json: @incoming_alert, status: :ok # TODO Render the object, and make status conditional
  end
end