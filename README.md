# DNS Challenge

### About

* Ruby 2.6.3
* Rails 5.2
* Docker

This API was created to manage DNS records.

### Install
Download the repo
* `git clone git@github.com:matheusam/dns_challenge.git`
cd to new created folder
* `cd dns_challenge`
Then build and run the container
* docker-compose build && docker-compose up
First time you build it you need to run
* `bin/setup`
In case you don't want seeds to be loaded just run this command to create databases and run migrations
* `rails db:setup`

After this, the API will be available at localhost:80, if you want to access the container to run the tests you can may run
* `docker-compose exec web bash`
And finally
* `rspec`
