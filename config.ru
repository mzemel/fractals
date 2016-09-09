require './app'
require './api'

# run Fractals::API
run Fractals::App.new

# run Rack::URLMap.new("/" => App.new, 
#                      "/api" => Api.new)