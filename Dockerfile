FROM ruby:2.7
RUN set -x && curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN set -x && apt-get update -y -qq && apt-get install -yq less lsof vim default-mysql-client

RUN set -x && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN set -x && apt-get update -y -qq && apt-get install -yq nodejs yarn

RUN mkdir /app
WORKDIR /app
COPY . /app

# Add a script to be executed every time the container starts.
COPY ./forDocker/rails/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
# ※docker-compose up で rails s するときはここのコメントを外す
# CMD ["rails", "server", "-b", "0.0.0.0"]
