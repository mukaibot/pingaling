# Pingaling Server
Once setup, the Pingaling Server provides monitoring and alerting functionality for your infrastructure. It's designed to be run as a Docker container and requires a Postgresql database.

## Installing the server
Pingaling requires a Postgresql database (developed against Postgres 10, but other versions will probably work) and Erlang 20 or greater. The easiest way to run Pingaling is with Docker. At a high level:

1. Setup a Postgres database
2. Run the Pingaling server as a Docker container

When you run the Pingaling server, you need to supply the following environment variables:

* `POSTGRES_USER` - username for the db, defaults to _postgres_
* `POSTGRES_PASS` - password for the user, defaults to _postgres_
* `POSTGRES_DB` - name of the database, defaults to _pingaling_
* `POSTGRES_HOST` - hostname of the database, defaults to _localhost_
* `PORT` - TCP port to listen on, defaults to _4000_

The Pingaling server is available at `pingaling/server` from [Docker Hub](https://hub.docker.com/r/pingaling/server/). The current release is 0.5 - `docker pull pingaling/server:0.5`

You'll need to make your Pingaling server accessible to the client.
