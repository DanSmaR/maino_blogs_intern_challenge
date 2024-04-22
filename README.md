# Maino Blog

Maino Blog is a web application that allows users to create and share blog posts. It's built with Ruby on Rails and uses 
PostgreSQL for data storage. The application is designed to be run in a Docker environment, making it easy to set up and 
run on any system.

See [Pendencies](#pendencies) to know more about the current state of the application.

## Purpose

The purpose of this application is to provide a platform for users to share their thoughts and ideas in the form of blog 
posts. Users can create, read, update, and delete posts, providing a full blogging experience. They can comment in a 
post too.

## Technologies

Maino Blog is built using the following technologies:

- **Ruby on Rails 7.1**: A powerful web application framework used for the backend.
- **Ruby 3.2**: A dynamic, open-source programming language with a focus on simplicity and productivity.
- **PostgreSQL**: A robust, open-source relational database system.
- **Docker**: A platform that enables developers to build, share, and run applications in any environment.
- **Devise**: A flexible authentication solution for Rails based on Warden.
- **Pagy**: A pagination library for Ruby on Rails.
- **Rspec**: A testing framework for Ruby.
- **Sidekiq**: A background processing framework for Ruby.
- **Redis 6.2**: An in-memory data structure store used as a database, cache, and message broker.
- **Bootstrap**: A popular CSS framework for building responsive and mobile-first websites.

## Running the App

To run the application, you need to have Docker and Docker Compose installed on your machine. Once you have these prerequisites, you can start the application by following these steps:
- You can get the latest version of [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/).

Certify that you have a postgresql service running on your machine.
```sh
sudo systemctl start postgresql
```

Certify that you have a redis service running on your machine.
```sh
sudo systemctl start redis
```

1. Clone the repository to your local machine.
2. Navigate to the project root directory in your terminal.
3. Rename the file `.env.example` to `.env` to set the environment variables.
4. Run the following commands to prepare the application:
```sh
bundle install
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

4. Run the following command to start the application:
```sh
rails s
```

## Accessing the App

To access the  app, open your browser and navigate to `http://localhost:3000/`

You can access the deployed application in the following link: [Maino Blog](https://mainoblog-silent-star-7101.fly.dev/)
deployed in [Fly.io](https://fly.io/)

## Running the Tests

To run the tests, you need to access the container maino-web. Then, run:

```sh
bundle exec rspec
```

## Pendencies

- You can use docker-compose to run the application. But the tests are not passing yet. I'm working on it. They
only pass when you run the tests in your local machine.

- To run the application with docker-compose, you need to run the following command:
```sh
docker-compose up
```
Don't forget to stop the local postgresql service before running the docker-compose:
```sh
sudo systemctl stop postgresql
```
And change the .env file to use the postgresql service in the docker-compose, setting the **POSTGRES_HOST** to `db`
and **REDIS_URL** to `redis://redis:6379/10` 

- The Job Async is not working in the deployed application, only in local machine. I'm working on it. The files uploaded
are being processed in the same thread.

- Improve the tags search and add posts search too.
