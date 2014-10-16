class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "DEV INTERCEPT: [#{message.to}] #{message.subject}"
    message.to = ""
  end
end
