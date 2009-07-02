# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_santa_session',
  :secret      => '4109c5a128b826704017e1099ab1db5456a6e47b9ef4caed2551f5ed970efc6299d83c70239f7e0bf586db766572eac8e13ea2feba4af7362f1812ad4ddf017f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
