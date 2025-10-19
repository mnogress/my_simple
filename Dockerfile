# FROM ruby:2.7.7-slim-bullseye
FROM debian:bullseye

#FROM ruby:2.7.1-buster

WORKDIR /work

COPY Gemfile /work/Gemfile
COPY type-on-strap.gemspec /work/type-on-strap.gemspec


# Set locale
RUN set -ex \
  && apt-get update \
  && apt-get install -y \
    locales \
    locales-all \
  && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# RubyとBundlerをインストール
RUN apt-get update && apt-get install -y \
    ruby \
    ruby-dev \
    build-essential \
 && gem install bundler

RUN apt-get update && apt-get install -y git


RUN set -ex \
  && cd /work \
  && bundle install \
  && rm -rf /root/.bundle/cache