source 'https://rubygems.org'
# ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'haml'
gem 'haml-rails'
gem 'animate-rails'
gem 'jquery-ui-rails'
gem 'spina'
gem 'carrierwave'
gem 'fog'
gem 'sendgrid-ruby'
gem 'devise'
gem 'materialize-sass'
gem 'material_icons'
gem 'aws-sdk', '~> 2'
gem 'sidekiq'
gem 'select2-rails'
gem "figaro"
gem 'stripe'
gem 'draper'

group :development, :test do
  gem 'byebug', platform: :mri

end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # gem 'tzinfo-data' # WINDOWS
  gem "better_errors"
  gem "binding_of_caller"
  gem 'pry'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
end
