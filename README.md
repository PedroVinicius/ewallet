## Introduction

Did you always dreamed about having your own bank but didn't know what to do to achieve that? We can help you with that!

e-Wallet is an API made from developers to developers so anyone can create their own bank services. Through a simple API you're able to easily manage your bank accounts. The only thing you need to do is follow the installation guide bellow and get started managing your money in an efficient and secure way.

With e-Wallet you help your customers to keep themselves in control of their money.

## System Requirements and Installation

e-Wallet was built and tested in an Unix environment. Non unix environments aren't supported at this moment. Before getting started, you need to install [PostgreSQL](https://www.postgresql.org/) and [RVM](https://rvm.io/).

Once you have fullfilled the prerequisites, go forward and:

1 - Run `rvm install 2.6.1`

2 - Run `rvm gemset create ewallet`

3 - Run `gem install bundler --no-doc`

4 - Run `bundle install`

5 - Config the database by moving the `config/database.sample.yml` to `config/database.yml` and changing it according to your settings (remember to create the PostgreSQL database first).

6 - Generate a key pair by running `bin/keygen` from the app root directory.

7 - Point the absolute path for both the private and public key generated in the previous step within a `.env` file and place it at the app root directory.

The variables need to be named as:

`PRIVATE_KEY_PATH='<ABS-PATH>`

`PUBLIC_KEY_PATH='<ABS-PATH>'`

8 - Run `bundle exec rake db:migrate`

9 - Run `rackup`

Here your app will be running on port :9292.

## API Endpoints

All endpoints respond with json format. We don't suport other formats at this moment.

First of all, you need to create an user:

```http
POST /api/v1/users HTTP/1.1
Accept: application/json
Content-Type: application/json
Authorization: Bearer <token>

{
  "user": {
    "first_name": "יחזקאל",
    "last_name": "בן אברהם",
    "email": "yechezkel.ben.avraham@gmail.com",
    "username": "yechezkel",
    "password": "yczklbnavrhm"
  }
}
```

So, for subsequent requests you will need to send an authentication token along with each request. 

Generate an authentication token for an existing user.

```http
POST /api/v1/users/sign_in HTTP/1.1
Accept: application/json
Content-Type: application/json

{
  "username": "yechezkel.ben.avraham@gmail.com",
  "password": "yczklbnavrhm"
}
```

Fetch all accounts from the logged user.
```http
GET /api/v1/accounts HTTP/1.1
Accept: application/json
Authorization: Bearer <token>

[
  {
    "id": 1,
    "number": 1,
    "name": "Professional Account",
    "created_at": "2019-02-16 22:51:12 -0300",
    "updated_at": "2019-02-16 22:51:12 -0300"
  },

  { 
    "id": 1,
    "number": 1,
    "name": "Professional Account",
    "created_at": "2019-02-16 22:51:12 -0300",
    "updated_at": "2019-02-16 22:51:12 -0300"
  }
]
```

Create a new account and associate it to the logged user.
```http
POST /api/v1/accounts HTTP/1.1
Accept: application/json
Authorization: Bearer <token>

{ 
  "account": {
    "number": 1,
    "name": "Professional Account",
    "user_id": 1,
    "created_at": "2019-02-16 22:51:12 -0300",
    "updated_at": "2019-02-16 22:51:12 -0300"
  }
}
```

Fetch a specific account including its balance.
```http
GET /api/v1/accounts/:id HTTP/1.1
Accept: application/json
Authorization: Bearer <token>

{
  "account": {
    "number": 1,
    "name": "Personal Account",
    "created_at": "2019-02-16 22:51:12 -0300",
    "updated_at": "2019-02-16 22:51:12 -0300",
    "balance": "100.00"
  }
}
```

Update account's informations.
```http
PUT /api/v1/accounts/:id HTTP/1.1
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>

{
  "account": {
    "id": 1,
    "number": 11111,
    "name": "Personal Account",
    "created_at": "2019-02-16 22:51:12 -0300",
    "updated_at": "2019-02-16 22:51:12 -0300"
  }
}
```

Send money to an existing account.
```http
POST /api/v1/accounts/:id/deposit HTTP/1.1
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>

{
  "deposit": {
    "amount": 123.0
  }
}
```

Withdraw money from an existing account.
```http
POST /api/v1/accounts/:id/withdraw HTTP/1.1
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>

{
  "withdrawal": {
    "amount": 123.0
  }
}
```

Transfer money between two accounts. In order to send money, you need to be the owner of the sender account. A balance higher than the amount to be sent is required to complete this action.
```http
POST /api/v1/accounts/:id/transfer/:destination_id HTTP/1.1
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>

{
  "transference": {
    "amount": 123.0
  }
}
```

## Console

If you dont't want to use the API to create your user, you can create it from console.

All you need to execute is to run `bin/console` from the app root. By doing that, all the models will be imediatelly available for you, and you can experiment as if you were working with Ruby on Rails.

## Contributing

As an open source project, contributions are wellcome, and we adopt a very simple git flow. If you have an idea and want to share it with us, whe first step is register it in the issues session. So, we will discuss and analyze it. Once your awesome idea has been approved, take the following steps:

1. Create a new branch following the pattern FEATURE-#0000, where "0000" is the issue number.
2. Run the tests suite to certify that everything is ok and to avoid regressions.
3. Create a pull request.

After your pull request has been approved, the code will be merged into the master branch.
