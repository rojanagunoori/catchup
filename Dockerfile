# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.4.1
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /app

# Runtime dependencies (needed in all stages)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        curl \
        libjemalloc2 \
        libvips \
        sqlite3 \
        libpq5 \
        nodejs \
        yarn \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Set production environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# Build stage
FROM base AS build

# Dev headers for building gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        build-essential \
        git \
        pkg-config \
        libsqlite3-dev \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && bundle exec bootsnap precompile --gemfile

# Copy app source
COPY . .

# Precompile bootsnap code
RUN bundle exec bootsnap precompile app/ lib/

# Make bin files executable
RUN chmod +x bin/* && sed -i "s/\r$//g" bin/*

# Final stage
FROM base AS final
WORKDIR /app

# Copy installed gems and app
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

# Non-root user
RUN groupadd --system --gid 1000 rails && \
    useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash rails && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

ENTRYPOINT ["bin/docker-entrypoint"]
EXPOSE 80
CMD bash -c "bundle exec rails db:migrate && bundle exec puma -C config/puma.rb"
#CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "80"]