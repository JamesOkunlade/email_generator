# Email generator 

## Introduction

This is an application that lets users find a valid and available email address based on the contacts's name and url


**Note** The application is based on rails ActiveJob. When a user is created, the model enqueus a job to perform an api check on the predefined different combinations of the contact's first name, last name and url. While the job is in the queue, the valid email field of a user record is set to "Checking for available valid email..." and once the job detects a valid combination, it updates the record field with the valid email found. The record field is set to "No available email" if upon the completion of the job no valid email was found.


Specification summary:

- ActiveJob
- ActiveModel
- Postgres database 
- Postgres database
- Mailboxlayer API

## Requirements

- Ruby version 2.6.2

- Rails version 6

- Postgres

## Installation

- Clone the repository and get inside it:

```
git clone git@github.com:JamesOkunlade/email_generator.git

cd email-generator
```

- Install all gems:

```
bundle install
```

- Create a postgres database:

```
rails db:create
```

- Migrate database

```
rails db:migrate
```

- Setup Mailboxlayer API Access key

```
Visit [Mailboxlayer](https://mailboxlayer.com/) to generate an access key
Find the email_validator file in the app/services folder
Replace the ACCESS_KEY='YOUR_ACCESS_KEY'
```


- Start the server

```
rails s
```

## Live Version

[Email generator](https://fierce-bastion-34096.herokuapp.com/)

The production app uses the free subscription of Mailboxlayer API so the number of requests might have been exhausted at the time of trying it. It's best to setup your own locally and create your own free/paid subscription to Mailboxlayer API to get an access key.

<!-- CONTACT -->

## Author

James Okunlade

- [Github profile](https://github.com/JamesOkunlade)