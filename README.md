# Listentothis

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Objective of this project

This projet will eventually be a browser of the listentothis subreddit, as of now the project is in its early stages.
### Objectives to be acomplished:

- [x] Create database schemas and migrations
- [x] Establish authentication (As seen in programming phoenix)
- [ ] Generate the video browser
- [ ] Improve on the reddit parser
- [ ] Rethink the reddit fetcher Genserver 
- [ ] Establish caching mechanisms for reddit links

## Current project Struncture

### lib/listener

Holds all the schemas for the tables of the system

### lib/listentothis_handler

This genserver will cache the last page requested by an user, reddit json api uses an after_code to request the new bundle of posts. the state of this server will hold the last link and bundled posts. As the database grows fewer request will be asked of this genserver as the likelihood of getting new posts will diminish.

### lib/listentothis_reddit

Comes as an aid to the Genserver, it does the actual fetching and parsing of the reddit links