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

##### *RECORD CREATION*
Send a POST request to `/api/v1/records` with and IPv4 address and an array of hosts(but you can also create a single record, just ensure that you send it as an array).
In case of success it will return the id of the created record and `201 http` code(:created). If fails, it will return `412 http` code (:unauthorized) and an generic error message.
e.g.

* `post /api/v1/records`

* `params = { ip: '9.9.9.9', hosts: ['foo.com', 'bar.com, 'foobar.com'] }`

Possible returns

* `status 201, record_id: 1`

* `status: 412, error: 'Sorry, try again.'`

##### *RECORD SEARCH*
Send a POST request to `/api/v1/records/search` with params to make a search, acepted  params are, `:page`(required), `:included`(hosts to include on search) and `:excluded`(hosts to exclude on search).
It will return the total number of matching DNS records(`:total`), an array of records containing id of record and ip. And other array with assosiated hostnames and number of matching DNS records for each of those.
e.g.

* `post /api/v1/records/search`

* You can search only using page number
* `params = { page: 1 }`

* Or you can search only results that include
* `params = { page: 1, included: ['foo.com'] }`

* Same thing for exluded results
* `params = { page: 1, excluded: ['bar.com, 'foobar.com'] }`

* And you can even try both together
* `params = { page: 1, included: ['foo.com'], excluded: ['bar.com, 'foobar.com'] }`

Some possible returns

* `status 200, total: 1, matches: { [id: 1, ip: 1.1.1.1]}, matches_hosts: { [host: foobar.com, total: 1] }`

* `status: 412, error: 'No results found.'`

Curl ex:
* `curl --header "Content-Type: application/json" \
--request POST \
--data '{"page":"1"}' \
http://localhost:80/api/v1/records/search`


returns:

* `{"total":1,"matches":[{"id":1,"ip":"1.1.1.1"}],"matches_hosts":[{"host":"lorem.com","total":1}]}`
