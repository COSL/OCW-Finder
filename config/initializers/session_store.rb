# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ocwfinder_session',
  :secret      => 'ae63737aef6ed452456e2136aed6ece4877b39a32a60c15358fcddab1f39b74c0bbb95d8260339c28f1db7f6062fc807ba519f3c78927df3aa60991c961cc2ee'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
