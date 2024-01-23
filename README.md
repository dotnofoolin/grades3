# Grades3

A simple dashboard for displaying my kids grades without having to navigate the school provided systems that are slow and tedious.

A key component is the [hac_adapter](https://github.com/dotnofoolin/hac_adapter) gem. It provides the data from the schools grade interface.

## Details

* Developed with Ruby on Rails. Pretty vanilla setup with an esbuild and sass assets builder.
* Bulma is the CSS framework for now.
* Keeping it simple with SQLite as the database adapter.
* rufus-scheduler gem is used to run the importer process twice a day. It's configured with `config/initializers/scheduler.rb`

## Setup

* HAC credentials are saved in the encrypted credentials file. `EDITOR=vim rails credentials:edit`
* Can list multiple accounts and schools. Format is:
    hac_credentials:
      - url: http://hac23.esp.k12.ar.us/HomeAccess
        school: Little Rock School District
        username: your_username
        password: your_password
      - url: http://hac23.esp.k12.ar.us/HomeAccess
        school: Pulaski County Special SD
        username: your_username
        password: your_password
* Note that the `url` needs to have the `/HomeAccess` path as well.

## Development

* After checking out the repo, run `bundle install` and `yarn install` to install dependencies. 
* Setup the database with `rails db:create` and `rails db:schema:load`.
* Run `bin/dev` to run the rails server.
  
## Testing
* Test are written in Minitest and use vanilla fixtures. The `faker` gem populates the fixtures with random data.
* Run `rails test:all` to run the tests, including the system tests.
