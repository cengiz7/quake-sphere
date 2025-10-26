# README

Showing recent earthquakes on the 3D Planet Earth by Rails / three-Globe.gl js libraries.

### Requirements
#### Method 1 - Foreman
  - Redis
  - Postgresql installation with postgis extension enabled. Preferably [postgresql v12](https://computingforgeeks.com/how-to-install-postgis-on-ubuntu-linux/).

#### Method 2 - Docker Compose
  - use docker-comopose.yaml to run project.

### Setup
- rake db:create
- rake db:migrate
- rake data_sources:seed_genres
- rake db:seed
- bundle exec sidekiq -C config/sidekiq.yml 

### Usage Notes
- To display and run recurring jobs from the sidekiq dasboard [go to this link.](localhost:3000/admin/sidekiq/recurring-jobs)  
  In development env you can access the page directly, however in other environments you have to use
   your sidekiq credentials defined in .env file.

#### Sources:
- [Globe.gl](https://globe.gl/)