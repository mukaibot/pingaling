FROM elixir:1.7

RUN mkdir /app
WORKDIR /app
COPY mix.exs .
COPY mix.lock .

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

COPY . /app
