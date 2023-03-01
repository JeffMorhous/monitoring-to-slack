# README

Making a POST request /alerts will result in a new row in the Alerts table with the
data of the incoming alert. If that alert is of type "SpamNotification", it will
also send a slack message asynchronously. 

## Configuring slack

You'll need to configure your slack workspace to accept incoming messages
from your application. The general process is described in
[the slack docs](https://api.slack.com/messaging/webhooks). I started by creating
a new workspace.

I [created a new slack app](https://api.slack.com/apps?new_app=1) and selected
my newly created workspace. Next, I enabled incoming webhooks (details in the doc above).

Next, I created a new webhook from the same page and selected a channel to send
the notifications to.

Copy the webhook URL, you'll need it for testing locally or production deployment.

## Testing locally

Run the following on your machine to install gems:

```bash
bundle install
```

Set the webhook URL in your environment variables to whatever you copied from slack:

```bash
export SLACK_ENDPOINT="<your-webhook-url>"
```

Run the rails server locally:


```bash
rails s
```

Now, you can hit `localhost:3000/alerts` with the following payload to generate an alert to slack:

```json
{
  "RecordType": "Bounce",
  "Type": "SpamNotification",
  "TypeCode": 512,
  "Name": "Spam notification",
  "Tag": "",
  "MessageStream": "outbound",
  "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
  "Email": "zaphod@example.com",
  "From": "notifications@honeybadger.io",
  "BouncedAt": "2023-02-27T21:41:30Z"
}
```

(Note the trailing comma from the example was removed as it was not valid JSON)

You can use the following payload and it will not generate an alert to slack, but will still
create a row in the alerts table:

```json
{
  "RecordType": "Bounce",
  "MessageStream": "outbound",
  "Type": "HardBounce",
  "TypeCode": 1,
  "Name": "Hard bounce",
  "Tag": "Test",
  "Description": "The server was unable to deliver your message (ex: unknown user, mailbox not found).",
  "Email": "arthur@example.com",
  "From": "notifications@honeybadger.io",
  "BouncedAt": "2019-11-05T16:33:54.9070259Z"
}
```

(Note the trailing comma from the example was removed as it was not valid JSON)

## Deploying to the web

## What I would do if I had more time

- Some error handling
  - What if the endpoint receives a request body that doesn't have what it needs?
  - What if the endpoint receives a request body that has what it doesn't need?
  - Right now the endpoint always returns 200, but that's probably not realistic
- Tests
  - Some controller-level tests
  - Some tests for the SlackNotificationJob
- Some JSON deserialization to make turning the request body into an object less fragile