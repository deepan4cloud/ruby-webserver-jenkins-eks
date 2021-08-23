FROM ruby:latest
WORKDIR /usr/src/app
#RUN bundle install
ADD . /usr/src/app/
EXPOSE 80
CMD ["ruby", "/usr/src/app/http_server.rb"]