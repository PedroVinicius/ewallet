FROM ruby:2.6.1-alpine3.8

RUN apk add postgresql-dev
RUN addgroup -S ewallet
RUN adduser -S ewallet -G ewallet
USER ewallet
WORKDIR /home/ewallet
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-doc
RUN bundle install
COPY . .
CMD [ "rackup" ]