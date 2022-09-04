ARG ruby_version=3.1-buster

FROM ruby:${ruby_version} AS tools

ARG dockerize_version=v0.6.1

RUN wget https://github.com/jwilder/dockerize/releases/download/${dockerize_version}/dockerize-linux-amd64-${dockerize_version}.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-${dockerize_version}.tar.gz \
    && rm dockerize-linux-amd64-${dockerize_version}.tar.gz


FROM ruby:${ruby_version} AS builder

ARG WORKDIR=/backend
ARG bundler_version=2.3.20

RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

COPY ./backend/Gemfile .
COPY ./backend/Gemfile.lock .

RUN apt-get update

RUN gem install bundler:${bundler_version}
RUN bundle install --jobs=4


FROM ruby:${ruby_version} AS development

ARG WORKDIR=/backend

RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

RUN apt-get update

COPY --from=tools /usr/local/bin/dockerize /usr/bin/dockerize
COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY ./docker/backend/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

RUN groupadd -g 1000 ruby \
    && useradd -m -s /bin/bash -u 1000 -g 1000 ruby
USER ruby

COPY --chown=ruby:ruby ./backend .

EXPOSE 8000

CMD ["rails", "server", "-b", "0.0.0.0"]


FROM ruby:${ruby_version} AS production

ARG WORKDIR=/backend
ENV RAILS_ENV=production

RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

RUN apt-get update

COPY --from=tools /usr/local/bin/dockerize /usr/bin/dockerize
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY ./backend .

COPY ./docker/backend/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["bundle", "exec", "puma",  "-C", "config/puma.rb"]
