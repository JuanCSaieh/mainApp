FROM ruby:3.0.6

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem update bundler
RUN apt-get update -qq && apt-get install -y yarn
RUN bundle install
RUN apt remove yarn
RUN apt-get update
RUN apt-get install yarn -y
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]