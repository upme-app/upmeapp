Aws.config.update({
  region: 'sa-east-1',
  credentials: Aws::Credentials.new(ENV['S3_KEY'], ENV['S3_SECRET']),
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET_NAME'])