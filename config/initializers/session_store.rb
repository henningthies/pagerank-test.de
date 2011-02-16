# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pagerank-test_session',
  :secret      => '29af17c987bbe11c1214433c249bcf2f46d9c7e73ea7685d4a23538265bd6b1dcb2cd2a903c3d7b37ed367881ee438cdd15d3829fd7c3412f0871f4f35556a47'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
