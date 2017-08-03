# testing for CI purposes
if Rails.env == "test"
  Sidekiq.configure_server do |config|
    config.redis = { url: "redis:6379" }
  end
  Sidekiq.configure_client do |config|
    config.redis = { url: "redis:6379" }
  end
else
  Sidekiq.configure_server do |config|
    config.redis = { url: "redis:6379" }
  end
  Sidekiq.configure_client do |config|
    config.redis = { url: "redis:6379" }
  end
end
