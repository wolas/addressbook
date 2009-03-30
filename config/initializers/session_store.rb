# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_addressbook_session',
  :secret      => 'ead039d1c1571d7c7ba185750dd89f5924b36d7f57a1709b5faac61bb1d6a719b740174b6b1cc8764bdf367e35a8f2bacd41d3b531717763ccc5ef783c5a592b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
