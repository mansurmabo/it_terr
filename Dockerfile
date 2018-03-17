FROM ruby:2.5
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

ENV RAILS_ENV test
ENV RACK_ENV test

RUN bundle install
COPY . /myapp

CMD bundle exec rake db:migrate; bundle exec puma -C config/puma.rb
