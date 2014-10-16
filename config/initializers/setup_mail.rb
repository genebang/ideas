require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "",
  :user_name            => "",
  :password             => "",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

# ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?

# ActionMailer::Base.default_url_options[:host] = "localhost:3000"
