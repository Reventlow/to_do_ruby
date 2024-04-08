
# to_do_ruby

This README documents the necessary steps to get the application up and running.

Please note I am still working on this and there are some issues
- Rails UJS not loading correctly
- Sessions are not handle correctly
- I want to seed some example tasks
- Use bootstrap on my login pages
- CI/CD actions for auto deployment with docker

## Ruby version

- Ruby 3.3.0
- Rails 7.1.3.2

Please ensure you have the correct Ruby version installed. You can use [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io) to manage Ruby versions.

## System dependencies

- SQLite3 
- Node.js
- Yarn

## Configuration

Clone the repository: https://github.com/Reventlow/to_do_ruby

```bash
git clone https://github.com/Reventlow/to_do_ruby
cd to_do_ruby
```

Install the dependencies:

```bash
bundle install
yarn install
```

## Database creation

Create the database and migrate the schema:

```bash
rails db:create
rails db:migrate
```

## Database initialization

Seed the database with initial data:

```bash
rails db:seed
```

## How to run the test suite

Execute the test suite with:

```bash
rails test
```

(or `rspec` if you are using RSpec for testing)

## Services (job queues, cache servers, search engines, etc.)

Describe any services used in the application, like Redis for ActionCable or Sidekiq for background jobs.

## Deployment instructions

working on it
