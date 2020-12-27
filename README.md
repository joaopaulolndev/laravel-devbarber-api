<p align="center"><img src="https://laravel.com/assets/img/components/logo-laravel.svg"></p>

# Getting started

# laravel-barber-api-mysql
Demo Project Laravel Barber

## Installation

Please check the official laravel installation guide for server requirements before you start. [Official Documentation](https://laravel.com/docs/6.0/installation#installation)


Clone the repository

    git clone git@gitlab.com:rodineiti/laravel-barber-api-mysql.git

Switch to the repo folder

    cd laravel-barber-api-mysql

Install all the dependencies using composer

    composer install

Copy the example env file and make the required configuration changes in the .env file

    cp .env.example .env
    
Set Database MYSQL in .env

    DB_CONNECTION=mysql
    DB_HOST=
    DB_PORT=
    DB_DATABASE=
    DB_USERNAME=
    DB_PASSWORD=

Generate a new application key

    php artisan key:generate
    
DUMP database file barbers.sql

Run the database migrations (**Set the database connection in .env before migrating**)

    php artisan migrate

PASSPORT - Create the encryption keys needed to generate secure access tokens

    php artisan passport:install

Start the local development server

    php artisan serve

You can now access the server at http://localhost:8000

To know the routes of the system, run the command:
    
    php artisan route:list