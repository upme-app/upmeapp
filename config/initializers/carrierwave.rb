CarrierWave.configure do |config|
  config.storage = :file

  #Use S3 if you want
  config.fog_credentials = {
    provider:               'AWS',
    region:                 ENV['S3_REGION'],
    aws_access_key_id:      ENV['S3_KEY'],
    aws_secret_access_key:  ENV['S3_SECRET']
  }

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

  config.fog_directory    = ENV['S3_BUCKET_NAME']

  config.fog_public     = true
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }

  config.enable_processing = !Rails.env.test?
end