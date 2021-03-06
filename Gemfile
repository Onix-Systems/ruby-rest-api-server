source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.2'

# Provides using Rails for API-only Apps
gem 'rails-api'

# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 0.18'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Shim to load environment variables from .env into ENV in development.
gem 'dotenv-rails'

# Token based authentication for Rails JSON APIs.
gem 'devise_token_auth'

# Standardized Multi-Provider Authentication
gem 'omniauth'

# Rack::Cors provides support for Cross-Origin Resource Sharing
# (CORS) for Rack compatible web applications
gem 'rack-cors', require: 'rack/cors'

# A Scope & Engine based, clean, powerful, customizable and
# sophisticated paginator for Rails 3 and 4
gem 'kaminari'

group :development, :test, :travis do
  # Call 'byebug' anywhere in the code to stop
  # execution and get a debugger console
  gem 'byebug'

  # Behaviour Driven Development for Ruby
  gem 'rspec-rails', '~> 3.0'

  # Provides Rails integration for factory_girl
  gem "factory_bot"

  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker'

  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners that test common Rails functionality.
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # This gem implements the rspec command for Spring.
  gem 'spring-commands-rspec'

  # Guard::RSpec allows to automatically & intelligently launch specs when files are modified.
  gem 'guard-rspec', require: false

  group :darwin do
    # FSEvents API with signals handled
    gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i
  end

  # RuboCop is a Ruby static code analyzer.
  gem 'rubocop', require: false

  # MailCatcher runs a super simple SMTP server which catches
  # any message sent to it to display in a web interface.
  gem 'mailcatcher'

  # Overcommit is a tool to manage and configure Git hooks.
  gem 'overcommit'
end
