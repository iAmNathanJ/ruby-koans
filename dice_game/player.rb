class Player

  attr_reader :name, :catchphrase, :score

  def initialize(options = {})
    if options[:name].empty?
      raise StandardError.new, "Please give your player a name..."
    end
    @name = options[:name]
    @catchphrase = options[:catchphrase]
    @score = 0
  end

  def update_score(score)
    @score += score
  end
end
