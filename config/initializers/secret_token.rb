# Be sure to restart your server when you modify this file.
#
# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
#
# NOTE: This is generated as part of running `rake dev:setup`, and stored
#       in .env (loaded by dotenv in dev/test, and Heroku in production).
Follow::Application.config.secret_token = ENV['RAILS_SECRET']
