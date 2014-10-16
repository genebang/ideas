require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.enable_processing = true
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id:      ENV.fetch('AWS_ACCESS_KEY'),
    aws_secret_access_key:  ENV.fetch('AWS_ACCESS_SECRET_KEY')
  }

  config.fog_directory = ENV.fetch('AWS_BUCKET')
end
