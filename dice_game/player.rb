class Player

  attr_reader :name, :catchphrase
  attr_accessor :score

  def initialize(options = {})
    if options[:name].empty?
      raise StandardError.new, "Please choose a name for your player..."
    end
    @name = options[:name]
    @catchphrase = options[:catchphrase]
    @score = 0
  end

  def to_s
    @name
  end

  def update_score(score)
    @score += score
  end
end
