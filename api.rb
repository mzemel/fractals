require 'json'
require 'grape'
require_relative 'fractal'

module Fractals
  class API < Grape::API

    format :json

    helpers do; end

    resource :fractals do
      content_type :png, "image/png"
      desc "Create a mandlebrot fractal from your SSN"
      post :mandelbrot do
        fractal = Fractal.new(params: params)
        if fractal.valid?
          content_type 'image/png'
          File.binread fractal.generate
        else
          name = params["name"].to_s.split(" ")
          content_type 'text/html'
          "That is not a social security number #{name.first} :(".strip
        end
      end
    end
  end
end
