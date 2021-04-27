FROM ruby:3.0.1

ENV NODE_VERSION 14
ENV INSTALL_PATH /opt/app
ENV BUNDLER_VERSION 2.2.15

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list.d/google.list

RUN apt-get update --fix-missing
RUN apt-get install -y --no-install-recommends nodejs \
      locales \
      postgresql-client \
      yarn \
      google-chrome-stable

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

RUN gem install bundler -v $BUNDLER_VERSION
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
RUN gem install bundler-audit -N

COPY . .

CMD ["rails", "server", "-b" "0.0.0.0"]
