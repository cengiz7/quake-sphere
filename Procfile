redis:    if redis-cli ping; then /bin/bash; else redis-server; fi
sidekiq:  bundle exec sidekiq -C config/sidekiq.yml
web:      rails s -p 3000