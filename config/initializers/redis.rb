#replace development if production
uri = URI.parse(Rails.application.credentials[:development][:redis_to_go_url])
REDIS = Redis.new(:url => uri)
