# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gem_session',
  :secret      => '2c254579fd09a1c520ccd2be110f87ee5487578ee3025ea00dfd616f41fc614594f88bf24abf876a6bd249dc43c3d1575fda07b3d464082c61bdb0b45811579f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
