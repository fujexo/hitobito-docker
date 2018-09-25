FROM ruby:2.2

RUN useradd hitobito -m
WORKDIR /home/hitobito

RUN curl -L https://github.com/hitobito/hitobito/archive/1.18.9.tar.gz | \
  tar -xz && \
  mv hitobito-* hitobito

ADD Wagonfile /home/hitobito/hitobito/Wagonfile
ADD startup.sh /home/hitobito/hitobito/startup.sh

WORKDIR /home/hitobito/hitobito

RUN apt update && \
  apt install -y mysql-client haveged sqlite memcached imagemagick && \
  bundle && \
  bundle exec rake db:create && \
  bundle exec rake db:setup:all

#RUN rvm 1.9.3 exec bundle config build.nokogiri --use-system-libraries && \
#  rvm 1.9.3 exec bundle install && \
#  sed -i 's/config.assets.compile = false/config.assets.compile = true/g' config/environments/production.rb && \
#  rvm 1.9.3 exec bundle exec rake assets:precompile

EXPOSE 80

#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "80"]
CMD ["/home/hitobito/hitobito/startup.sh"]
