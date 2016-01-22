require_relative '../neo'
require_relative 'game'
require_relative 'player'
require_relative 'dice'

class AboutDiceGame < Neo::Koan

  def test_new_dice_set_requires_one_arg
    assert_raise(StandardError) do
      dice = DiceSet.new
    end

    assert_nothing_raised do
      dice = DiceSet.new(5)
    end
  end

  def test_dice_roll_returns_array
    dice = DiceSet.new(5)

    result = dice.roll.class
    assert_equal result, Array
  end

  def test_dice_roll_array_values_are_numbers
    dice = DiceSet.new(5)

    roll = dice.roll

    roll.each do |die|
      assert_equal die.class, Fixnum
    end
  end

end
