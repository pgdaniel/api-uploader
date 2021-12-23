require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400

run Sidekiq::Web
