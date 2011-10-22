# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CsnipNew::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "mail.tigertech.net",
  :port                 => 587,
  :user_name            => 'appointmentrequest@csnip.org',
  :password             => 'retuen12',
  :authentication       => :login,
  :enable_starttls_auto => true  }
