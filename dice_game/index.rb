# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

########################################
# Dice Game
########################################

# include DiceSet class
require_relative 'dice'

# include Player class
require_relative 'player'

# Colors
require 'colorize'

class Game

  #############################################
  # Setup
  #############################################

  attr_reader :players, :turn, :play_to, :winner

  def initialize(dice_count = 5, play_to = 2000)
    @players = []
    @dice = DiceSet.new(dice_count)
    @play_to = play_to
  end

  #############################################
  # Convenience Methods
  #############################################

  # Get input
  def take(message)
    print message.light_yellow
    yield(gets.chomp)
  end

  # Messages to player
  def inform(str, color = "cyan")
    print "\n#{str.public_send(color)}\n"
  end

  # Count occurances of a value in an array
  def tally_item(arr, val)
    arr.count { |item| item == val }
  end


  #############################################
  # Scoring
  #############################################

  # Find 3 of a kind or return false
  def get_score(dice)

    # Initialize score
    cur_score = 0

    # Sort dice
    dice.sort!

    # Find 3 of kind
    for i in 1..6
      if tally_item(dice, i) > 2
        # Add the 3 of kind score
        i == 1 ? cur_score += 1000 : cur_score += (i * 100)
        # Slice out 3 of kind
        dice.slice!(dice.index(i), 3)
      end
    end

    # Get remaining score
    remaining_score = dice.map do |item|
      if item == 1
        100
      elsif item == 5
        50
      else
        0
      end
    end.inject { |acc, val| acc + val } || 0

    cur_score + remaining_score
  end


  #############################################
  # Game Flow
  #############################################

  def next_turn
    current_player = players[0]
    take("Hit any key to roll the dice...") do |input|
      if input
        roll = @dice.roll
        score = get_score(roll)
        inform "#{current_player[:name]}'s roll: #{roll}"
        inform "Score: #{score}"
        current_player.score += score
        if current_player >= @play_to
          # END GAME
        end
      end
    end

    @players.rotate!
  end


  #############################################
  # Player Management
  #############################################

  def add_player(player = {})

    # Allow 4 players max
    return inform "This game is full." unless @players.length < 4

    # Get player name
    take("Player #{@players.length + 1}: Enter your name: ") do |input|
      if input.empty?
        raise StandardError.new, "Please enter your player's name..."
      else
        player[:name] = input
      end
    end

    # Get Catchphrase
    take("Do you have a catchphrase? ") do |input|
      player[:catchphrase] = input
    end

    @players << Player.new(player)

    take("Add another player? ") do |input|
      add_player if input == "y" || input == "yes"
    end

    rescue StandardError => e
      inform "! #{e.message}", "red"
      inform "Current player info: #{player}"
      return add_player(player)
  end

end

game = Game.new
game.add_player
p game.players