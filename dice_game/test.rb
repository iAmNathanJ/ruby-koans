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


  ##################################################
  # ??? to_s should be implicit?
  ##################################################

  def test_player_to_s_retuns_player_name
    player = Player.new( :name => 'name' )
    assert_equal player.to_s, 'name'
    # assert_equal player, 'name' # implicit call doesn't work?
  end

  def test_player_scoring
    player = Player.new( :name => 'name' )
    assert_equal player.score, 0
  end

  def test_game_defaults
    game = Game.new

    # players should start as an empty array
    assert_equal game.players, []

    # game.dice should be instance of DiceSet class
    # assert_equal game.dice.instance_of?, DiceSet
  end

end
