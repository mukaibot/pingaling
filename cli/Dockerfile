FROM ruby:2.5

RUN curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -o /usr/bin/waitforit && chmod +x /usr/bin/waitforit

RUN mkdir /app
WORKDIR /app
COPY cli/Gemfile /app
COPY cli/Gemfile.lock /app
COPY api/docs/api.md /api/docs/api.md
RUN bundle install

COPY cli /app
CMD waitforit api_acceptance_tests:4000 --timeout=120 && bundle exec rake all_the_tests
