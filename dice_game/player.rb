class Player

  attr_accessor :name, :catchphrase, :score

  def initialize(options = {})
    @name = options[:name]
    @catchphrase = options[:catchphrase]
    @score = 0
  end

  def to_s
    "#{@name}"
  end

end
