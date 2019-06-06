# DNS Challenge

### About

* Ruby 2.6.3
* Rails 5.2
* Docker

This API was created to manage DNS records.

### Install
* Download the repo
* `git clone git@github.com:matheusam/dns_challenge.git`

* cd to new created folder
* `cd dns_challenge`

* Then build and run the container
* `docker-compose build && docker-compose run web bash`

* First time you build it you need to run
* `bin/setup`

* In case you don't want seeds to be loaded just run this command to create databases and run migrations
* `rails db:setup`

* After this, the API will be available at localhost:80, if you want to access the container to run the tests you can may run
* `docker-compose exec web bash`

* And finally
* `rspec`


### **API** Documentation

Above is listed all available end-points. We currently support two operations, **record creation** and **retrieve a record**.

_*RECORD CREATION*_
Send a POST request to `/api/v1/records` with and IPv4 address and an array of hosts(but you can also create a single record, just ensure that you send it as an array).
In case of success it will return the id of the created record and `201 http` code(:created). If fails, it will return `412 http` code (:unauthorized) and an generic error message.
e.g.

* `post /api/v1/records/<params>`

* `params = { ip: '9.9.9.9', hosts: ['foo.com', 'bar.com, 'foobar.com'] }`

Possible returns

* `status 201, record_id: 1`

* `status: 412, error: 'Sorry, try again.'`
