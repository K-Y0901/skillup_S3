# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


# メール機能
ActionMailer::Base.smtp_settings = {
  :user_name => 'apiky',
  :password => 'test',
  :domain => 'yourdomain.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}