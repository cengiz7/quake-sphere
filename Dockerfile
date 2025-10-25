FROM ruby:3.1.1-slim

# Install build dependencies and PostgreSQL client libraries
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Set arguments for user and group IDs
ARG UID=1000
ARG GID=1000

# Create a non-root user with specified UID and GID
RUN groupadd -g $GID -o appuser && \
    useradd -m -u $UID -g $GID -o -s /bin/bash appuser

# Set working directory
WORKDIR /app

# Set bundler path
ENV BUNDLE_PATH /usr/local/bundle

# Grant permissions to appuser for bundle path and app dir
RUN mkdir -p /usr/local/bundle && \
    chown -R appuser:appuser /app /usr/local/bundle

# Switch to the non-root user
USER appuser

# Copy Gemfile and Gemfile.lock and install gems as appuser
COPY --chown=appuser:appuser Gemfile* ./
RUN gem install bundler && \
    bundle install --jobs 4 --retry 3

# Copy the rest of the application code as appuser
COPY --chown=appuser:appuser . .

# Expose port and set default command
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]