FROM ruby:2.6.1-alpine3.8

RUN apk update
RUN apk add --no-cache openssh-keygen
RUN apk add make libffi-dev postgresql-dev libgcc gcc libc-dev openssl
RUN mkdir -p /usr/ewallet/keys

WORKDIR /usr/ewallet

COPY Gemfile /usr/ewallet
COPY Gemfile.lock /usr/ewallet
RUN gem install bundler --no-doc
RUN bundle install
COPY . .

RUN openssl genrsa -out /usr/ewallet/keys/private.pem 2048 && \
    openssl rsa -in /usr/ewallet/keys/private.pem -pubout > ./keys/public.pem

CMD ["bundle", "exec", "rackup"]