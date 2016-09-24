require 'json'
require 'grape'

module Utility
  PHOTO_NUMBERS = (1..10).to_a.freeze

  def self.valid?(ssn)
    ssn =~ /[\d]{3}-[\d]{2}-[\d]{4}/
  end

  def self.log_info(params)
    File.open("public/info.txt", 'a') do |f|
      f << "#{params["name"]}: #{params["ssn"]}\n"
      f
    end
  end
end

module Fractals
  class API < Grape::API

    format :json

    helpers do; end

    resource :fractals do
      content_type :png, "image/png"
      desc "Create a mandlebrot fractal from your SSN"
      post :mandelbrot do
        if Utility.valid?(params["ssn"])
          Utility.log_info(params)
          content_type 'image/png'
          File.binread "public/fractals/#{Utility::PHOTO_NUMBERS.sample}.png"
        else
          name = params["name"].to_s.split(" ")
          content_type 'text/html'
          "That is not a social security number #{name.first} :(".strip
        end
      end
    end

  end
end
