require 'json'
require 'grape'

module Fractals
  PHOTO_NUMBERS = (1..10).to_a.freeze

  def self.valid?(ssn)
    ssn =~ /[\d]{3}-[\d]{2}-[\d]{4}/
  end

  def self.log_info(params)
    File.open("public/info.txt", 'a') do |f|
      f << "#{params["name"]}: #{params["ssn"]}\n"
    end
  end

  def self.fractal_path(ssn)
    seed     = PHOTO_NUMBERS.sample
    photo_id = "#{seed}"
    # photo_id = "#{seed}_#{Time.now.to_i}"
    generate_fractal(ssn, photo_id)
    bg_clear_fractal(photo_id)
    return "public/generated_fractals/#{photo_id}.png"
  end

  # Use imagemagick to superimpose ssn on photo
  # cp for now
  def self.generate_fractal(ssn, photo_id)
    FileUtils.cp(
      "public/base_fractals/#{photo_id}.png",
      "public/generated_fractals/#{photo_id}.png"
    )
  end

  def self.bg_clear_fractal(photo_id)
    system("./cleanup_file #{photo_id} &")
  end

  class API < Grape::API

    format :json

    helpers do; end

    resource :fractals do
      content_type :png, "image/png"
      desc "Create a mandlebrot fractal from your SSN"
      post :mandelbrot do
        if Fractals.valid?(params["ssn"])
          Fractals.log_info(params)
          content_type 'image/png'
          File.binread Fractals.fractal_path(params["ssn"])
        else
          name = params["name"].to_s.split(" ")
          content_type 'text/html'
          "That is not a social security number #{name.first} :(".strip
        end
      end
    end

  end
end
