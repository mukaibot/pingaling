FROM elixir:1.7 as development

ENV MIX_ENV dev
ENV PORT 4000

RUN mkdir /app
WORKDIR /app
COPY api/mix.exs .
COPY api/mix.lock .
COPY version.txt .

RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix deps.get

COPY api /app

EXPOSE 4000
CMD mix ecto.migrate && mix phx.server

FROM elixir:1.7 as production-build
ENV MIX_ENV prod
ENV PORT 4000

COPY --from=development /root/.mix /root/.mix
COPY --from=development /app /app
WORKDIR /app

RUN mix release

FROM erlang:21 as production
ENV MIX_ENV prod
ENV PORT 4000
EXPOSE 4000

COPY --from=production-build /app/_build/prod/rel/api /app

CMD /app/bin/api migrate && /app/bin/api foreground
