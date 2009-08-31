# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
end

ActionMailer::Base.delivery_method = :sendmail

# The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
# config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
# config.i18n.default_locale = :de
I18n.default_locale = 'it'

LOCALES_DIRECTORY = "#{RAILS_ROOT}/config/locales"
LOCALES_AVAILABLE = Dir["#{LOCALES_DIRECTORY}/*.{rb,yml}"].collect do |locale_file|
  I18n.load_path << locale_file
  File.basename(File.basename(locale_file, ".rb"), ".yml")
end.uniq.sort
