# config/initializers/solid_queue.rb

SolidQueue.configure do |config|
  # Use your main production database for SolidQueue
  config.database = :production
end