class AlertsController < ApplicationController

  def create
    request_body = JSON.parse request.body.string
    # TODO Parse the body with a PORO
    render json: {}, status: :ok # TODO Render the object, and make status conditional
  end
end