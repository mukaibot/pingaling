FROM elixir:1.7

ENV MIX_ENV production
ENV PORT 4000

RUN mkdir /app
WORKDIR /app
COPY mix.exs .
COPY mix.lock .

RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix deps.get

COPY . /app

EXPOSE 4000
CMD mix ecto.migrate && mix phx.server
