FROM ruby:2.5

RUN curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -o /usr/bin/waitforit && chmod +x /usr/bin/waitforit

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app
COPY Gemfile.lock /app
RUN bundle install

COPY . /app
CMD waitforit api_acceptance_tests:4000 --timeout=120 && bundle exec rspec
