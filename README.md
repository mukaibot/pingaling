# Pingaling - monitoring for all kinds of things

What does it monitor?

* Web endpoints
* Cronjobs
* Presence of specific files in S3 Buckets

How can it alert you?

* PagerDuty
* Slack

Why should I use it?

* Declarative usage, designed for GitOps
* One system to monitor all the bits of your distributed applications
* Thoughtful command-line driven interface, built with a focus on operator pleasure


# Development

## Running the API
The API is an Elixir and Phoenix app. You need to install Elixir and then run:

```
mix deps.get
mix ecto.reset
mix phx.server
```
