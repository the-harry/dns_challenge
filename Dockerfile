FROM ruby:2.6

RUN apt-get update -qq

WORKDIR /home
COPY . /home

RUN gem install bundler && bundle install
