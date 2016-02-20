class Rack::Attack
  # your custom configuration...
  Rack::Attack.throttle('req/ip', limit: 2000, period: 3.minutes) do |req|
    req.ip
  end
end