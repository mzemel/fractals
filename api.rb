require 'json'
require 'grape'

module Fractals
  class API < Grape::API
    format :json

    helpers do; end

    resource :fractals do
      desc "Create a mandlebrot fractal from your SSN"
      post :mandelbrot do
        {status: "ok"}
      end

      desc "POST test"
      post :test do
        {name: params["name"], ssn: params["ssn"]}
      end

      desc "Generate a mnemonic from your SSN"
      post :mnemonic do
        {status: "ok"}
      end

      desc "GET Test"
      get :test do
        {status: "ok"}
      end
    end
  end
end