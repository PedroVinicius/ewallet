## Introduction

Did you always dreamed about having your own bank but didn't know what to do to achieve that? We can help you with thatQ

e-Wallet is an API made from developers to developers so anyone can create theyr own bank services. Through a simple API you're able to easily manage your bank accounts. The only thing you need to do is follow the installation guide bellow and get started managing your money in an efficient and secure way.

With e-Wallet you help your customers to keep themselves in control of their money.

## System Requirements and Installation

e-Wallet was built and tested in an Unix environment. Non unix environments aren't supported at this moment¹. In order to install it, you have to choose from one of the following options:

1 - Using Docker Compose (recommended)

`docker-compose up`

2 - Installing all dependencies by yourself

## API Endpoints

Register a new user

```http
POST /users HTTP/1.1
Accept: application/json
Content-Type: application/json
Authorization: Bearer <token>

{
  "user": {
    "first_name": "יחזקאל",
    "last_name": "בן אברהם",
    "email": "yechezkel.ben.avraham@gmail.com",
    "password": "yczklbnavrhm"
  }
}
```

Generate an authentication token for an existing user.

```http
POST /users/sign_in HTTP/1.1
Accept: application/json
Content-Type: application/json

{
  "user": {
    "email": "yechezkel.ben.avraham@gmail.com",
    "password": "yczklbnavrhm"
  }
}
```

Fetch all accounts.
```http
GET /accounts HTTP/1.1
Accept: application/json
Authorization: Bearer <token>

[
  { 
    "number": "0001",
    "name": "Professional Account",
    "description": "This is the account use for professional purposes.",
    "bank_id": 1
  },

  { 
    "number": "0001",
    "name": "Personal Account",
    "description": "This is the account use for personal purposes.",
    "bank_id": 2
  }
]
```

Create a new account.
```http
POST /accounts HTTP/1.1
Accept: application/json
Authorization: Bearer <token>

{ 
  "account": {
    "number": "0001",
    "name": "Professional Account",
    "description": "This is the account use for professional purposes.",
    "bank_id": 1
  }
}
```

Fetch a specific account.
```http
GET /accounts/:id HTTP/1.1
Accept: application/json
Authorization: Bearer <token>

{
  "account": {
    "number": "0001",
    "name": "Personal Account",
    "description": "This is the account I use for personal purposes.",
    "bank_id": 1
  }
}
```

Update account's informations.
```http
PUT /accounts/:id HTTP/1.1
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>

{
  "account": {
    "number": "0001",
    "name": "Personal Account",
    "description": "This is the account I use for personal purposes.",
    "bank_id": 1
  }
}
```

Send money to an existing account.
```http
POST /accounts/:id/deposit HTTP/1.1
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
POST /accounts/:id/withdraw HTTP/1.1
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>

{
  "withdrawal": {
    "amount": 123.0
  }
}
```

Transfer money between two accounts. In order to send money, you need to be the owner of the sender account.
```http
POST /accounts/:id/transfer/:destination_id HTTP/1.1
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>

{
  "transference": {
    "amount": 123.0
  }
}
```

## Contributing

As an open source project, contributions are wellcome, and we adopt a very simple git flow. If you have an idea and want to share it with us, whe first step is register it in the issues session. So, we will discuss and analyze it. Once your awesome idea has been approved, take the following steps:

1. Create a new branch following the pattern FEATURE-#0000, where "0000" is the issue number.
2. Run the tests suite to certify that everything is ok and to avoid regressions.
3. Create a pull request.

After your pull request has been approved, the code will be merged with the master branch.