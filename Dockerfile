FROM ruby:3.0.2

RUN set -x && curl -sL https://deb.nodesource.com/setup_lts.x | bash -

RUN set -x && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN set -x && apt-get update -qq && apt-get install -yq nodejs yarn vim
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

RUN yarn install --check-files
RUN bundle exec rails webpacker:install