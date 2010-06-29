# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_maximus_session',
  :secret      => '73366001ba404f2e76fc2bd8a6d16c3dd4dc1c0e42bf33477df093b6cee84c9a38cac0c30808ef909d5bccdc87d190ebdebd46a09601e56a0dc80c891c41f6e3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
