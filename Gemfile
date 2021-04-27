source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rexml', '~> 3.2', '>= 3.2.5'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'fabrication'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'webdrivers'
end
