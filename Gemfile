source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'thin'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Heroku
group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'sqlite3-ruby', require: 'sqlite3'

  # For debug
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'hirb-unicode'
  gem 'better_errors'
  gem 'binding_of_caller'
end

