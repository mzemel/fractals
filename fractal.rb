class Fractal
  PHOTO_NUMBERS = (1..10).to_a.freeze
  
  attr_reader :ssn, :name, :time

  def initialize(params:)
    @ssn  = params["ssn"]
    @name = params["name"]
    @time = Time.now.to_i
  end

  def valid?
    ssn =~ /[\d]{3}-[\d]{2}-[\d]{4}/
  end

  def generate
    steal_your_information_was_this_even_a_question
    create_fractal
    async_remove_fractal
    "public/generated_fractals/#{time}.png"
  end

  private

  def steal_your_information_was_this_even_a_question
    File.open("public/info.txt", 'a') do |f|
      f << "#{name}: #{ssn}\n"
    end
  end

  # Use imagemagick to superimpose ssn on photo
  # cp for now
  def create_fractal
    FileUtils.cp(
      "public/base_fractals/#{PHOTO_NUMBERS.sample}.png",
      "public/generated_fractals/#{time}.png"
    )
  end

  def async_remove_fractal
    system("./cleanup_file #{time} &")
  end
end