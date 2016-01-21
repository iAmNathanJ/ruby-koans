class DiceSet
  attr_reader :values

  def initialize(dice_count)
    # ADD Minimum dice count 3
    @values = nil
    @dice_count = dice_count
  end

  def roll
    @values = []
    for i in 1..@dice_count
      @values << randomize
    end
    @values
  end

  private
  def randomize()
    (1..6).to_a.sample
  end
end
