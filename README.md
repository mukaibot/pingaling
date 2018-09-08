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

Pingaling requires a Postgresql database (developed against Postgres 10, but other versions will probably work) and Erlang. The easiest way to run Pingaling is with Docker. At a high level:

1. Setup a Postgres database
2. Run the Pingaling server as a Docker container
3. Run the Ruby client `bin/pingaling` (in the `cli` directory) to interact with the server

When you run the Pingaling server, you need to supply the following environment variables:

* `POSTGRES_USER` - username for the db, defaults to _postgres_
* `POSTGRES_PASS` - password for the user, defaults to _postgres_
* `POSTGRES_DB` - name of the database, defaults to _pingaling_
* `POSTGRES_HOST` - hostname of the database, defaults to _localhost_
* `PORT` - TCP port to listen on, defaults to _4000_

The Pingaling server is available at `pingaling/server` from [Docker Hub](https://hub.docker.com/r/pingaling/server/)

The Pingaling client can be configured with `pingaling config` to point to your instance of the API

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
The client is currently written in Ruby (assumes Ruby 2.5), but we are planning to re-write this into Golang once the API has all major planned features.

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
