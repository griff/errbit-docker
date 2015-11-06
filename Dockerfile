FROM ubuntu:14.04
MAINTAINER Brian Olsen <brian@maven-group.org>

# Install packages for building ruby
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential curl git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2 libxml2-dev libxslt-dev libcurl4-openssl-dev

# Install ruby
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/ruby-build
ENV RUBY_VERSION 2.1.4
RUN /usr/local/ruby-build/bin/ruby-build $RUBY_VERSION /opt/ruby

ENV RACK_ENV production
ENV RAILS_ENV production
ENV USE_ENV true
ENV ERRBIT_EMAIL_FROM errbit@example.com
ENV PORT 3000

# Install bundler
RUN /opt/ruby/bin/gem install bundler

RUN /usr/sbin/useradd --create-home --home-dir /opt/errbit --shell /bin/bash errbit
USER errbit

# Install errbit
RUN git clone https://github.com/griff/errbit.git /opt/errbit/app

WORKDIR /opt/errbit/app
RUN /opt/ruby/bin/bundle install --deployment
RUN PATH=/opt/ruby/bin:$PATH bundle exec rake assets:precompile

ADD launch.bash /opt/launch.bash
EXPOSE 3000
ENTRYPOINT   ["/opt/launch.bash"]
CMD ["web"]