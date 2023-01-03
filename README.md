# DDD example in Ruby on Rails

This is a PoC application for implementing elements of Domain-Driven Design inside of a plain Ruby on Rails application.

THIS IS NOT PRODUCTION-LEVEL CODE. Its purpose is to serve as a validation of ideas and a discussion starting point.

## Identified Subdomains and implemented Bounded Contexts

### DragonHunt
Our company organises raids on dragons. But we need to assemble the parties first

### CooperationNegotiation
Before a party is assembled, its leader needs to negotiate a contract. The contract signature is the defining moment for the party to be assembled.

## Implemented scenario, joining two contexts

It implements a simple scenario (using ubiquitous languages for each of the domains):
- start negotiation by preparing a draft contract
- modify text of the contract to satisfy the client and the company
- the contract, in its final text form, needs to be signed by the client
- the contract, in its final text form, needs to be signed by the company
- when both sides sign the contract, it cannot be modified further
- signed contracts can be listed, including the text of contract and the time it has been signed
- when the contract is signed by both sides, a party is assembled in the DragonHunt context

## Used DDD features

- contexts defined as modules inside of `app/modules/` folder
- layers defined in each modules within `application|domain|infrastructure` folders
- repositories put into `infrastructure` layer
- persistance models put into `infrastructure` layer and translated into/out of domain models using repositories
- application services for each possible action within `cooperation_negotiation` context
- domain objects defined as POROs
- domain events defined as POROs
- domain events handled synchronously and used for cross-context communication
- factory methods defined on domain objects
- read models

## Installation

```sh
rails db:create
rails db:migrate

rails db:seed
```

## Reply all test scenarios with

```
rails db:seed:replant
```

## Testing

The project uses Rspec as its testing framework. Run
```
rspec
```
to run all tests.

For continues testing during development you may use Guard with
```
guard
```

## Future plans

- I'm thinking about adding some controllers and frontend to show that it can operate as a normal application.

## Enjoy
Please let me know if you see anything you like, don't like or think can be done better
