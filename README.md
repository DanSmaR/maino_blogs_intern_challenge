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

1. Clone the repository to your local machine.
2. Navigate to the project root directory in your terminal.
3. Rename the file `.env.example` to `.env` to set the environment variables.
4. Run the following commands to prepare the application:

- To run the application with docker-compose, you need to run the following command:
```sh
docker-compose up --build
```

## Accessing the App

To access the  app, open your browser and navigate to `http://localhost:3000/`

You can access the deployed application in the following link: [Maino Blog](https://mainoblog-silent-star-7101.fly.dev/)
deployed in [Fly.io](https://fly.io/)

## Running the Tests

To run the tests, you need to access the container maino-web, the run the test:

```sh
docker exec -it maino-web -bash
bundle exec rspec
```

## Pendencies
- The Job Async is not working in the deployed application, only in local machine. It is processing the file in sync.
  In this PR I have modified the logic to use tempfile instead of saving a file in the server in order to read it later 
  in the job perform method. This could make the deployed app work correctly.

- Improve the tags search and add posts search too.
