# README

Showing recent earthquakes on the 3D Planet Earth by Rails / three-Globe.gl js libraries.

### Requirements
- Redis
- Postgresql installation with postgis extension enabled. Preferably [postgresql v12](https://computingforgeeks.com/how-to-install-postgis-on-ubuntu-linux/).

### Setup
- rake db:create
- rake db:migrate
- rake data_sources:seed_genres
- rake db:seed
- bundle exec sidekiq -C config/sidekiq.yml 

Sources:
- [Globe.gl](https://globe.gl/)