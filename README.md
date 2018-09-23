# Pingaling - monitoring for all kinds of things

What does it monitor?

* Web endpoints
* Cronjobs (soon)
* Presence of specific files in S3 Buckets (soon)

How can it alert you?

* PagerDuty (soon)
* Slack

Why should I use it?

* Declarative usage, designed for GitOps
* One system to monitor all the bits of your distributed applications
* Thoughtful command-line driven interface, built with a focus on operator pleasure

# Getting up and running
## Set up
See [api/README.md](api/README.md) for instructions on setting up the server and [cli/README.md](cli/README.md) for the client

# Usage
Once you have the Pingaling server running, you can use the client to configure and interogate the service. Pingaling is heavily inspired by Kubernetes and `kubectl`.

Configuring monitoring and notifications is done by writing a YAML file, and then applying this with the client. All operations are idempotent, making this ideal for CI / GitOps workflows.

## Sample YAML files
The preferred method of making changes with Pingaling is to use the client:
`pingaling apply -f file.yaml`

Here are some sample YAML files you can adapt for your own use cases:

* Endpoint check: [cli/doc/endpoint_sample.yml](cli/doc/endpoint_sample.yml)
* Slack channel to be notified: [cli/doc/slack_sample.yml](cli/doc/slack_sample.yml)
* Notification policy sample (links the Endpoint to the Slack channel): [cli/doc/notification_policy_sample.yml](cli/doc/notification_policy_sample.yml)

## Checking the health of Endpoints
Get the health of all configured Endpoints
`pingaling get endpoints`

## Viewing Incidents
An Incident will be raised when an Endpoint is deemed to be unhealthy
`pingaling get incidents`

Incident and Endpoint status:

* *Pending:* the Endpoint has not been checked by Pingaling yet (it's probably only just been added)
* *Open:* the Endpoint is currently unhealthy
* *Auto-resolved:* the Endpoint was unhealthy, but has since recovered

# Development
## Running the API
The API is an Elixir and Phoenix app. You need to install Elixir and then run:

```
mix deps.get
mix ecto.reset
mix phx.server
```

## Running the client
Ruby 2.5 or higher is recommended

```bash
bundle install
bin/pingaling
```

## Running API tests
Tests for both the client and API are packaged with Docker Compose:

API tests:
`docker-compose run api_test`

Client tests (includes acceptance / E2E tests):
`docker-compose run cli`
