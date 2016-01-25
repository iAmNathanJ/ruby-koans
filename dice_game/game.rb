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

# include Console class
require_relative 'console'

# Colors
require 'colorize'

class Game

  #############################################
  # Setup
  #############################################

  attr_reader :players, :play_to, :dice, :winner, :max_players

  def initialize(dice_count = 5, play_to = 2000)
    @players = []
    @dice = DiceSet.new(dice_count)
    @play_to = play_to
    @max_players = 4
    @winner = nil
  end


  #############################################
  # Scoring
  #############################################

  # Find 3 of a kind or return false
  def get_score(dice)

    # Initialize score
    score = 0

    # Sort dice
    sorted_dice = dice.sort

    # Find 3 of kind
    for i in 1..6
      if (sorted_dice.count i) > 2
        # Add the 3 of kind score
        i == 1 ? score += 1000 : score += (i * 100)
        # Slice out 3 of kind
        sorted_dice.slice!(sorted_dice.index(i), 3)
        break
      end
    end

    # Get remaining score
    sorted_dice.each do |die|
      score += 50 if die == 5
      score += 100 if die == 1
    end

    score
  end


  #############################################
  # Players
  #############################################

  def add_player

    player = Player.new

    # Allow 4 players max
    return Console.inform "This game is full." unless players.length < 4

    # Get player name & catchphrase
    player.name = Console.take("Player #{players.length + 1}: Enter your name: ")

    # TODO Check player has at least a name?

    player.catchphrase = Console.take("Do you have a catchphrase? ")
    players << player

  end


  #############################################
  # Game Play
  #############################################

  def play

    for i in (1..max_players)
      add_player
      another_player = Console.take("Add player? (y or n) ").upcase
      break if another_player[0] != 'Y'
    end

    while !winner do

      players.each do |current_player|

        go = Console.take("#{current_player}, you're up! Hit enter to roll the dice...")
        if go

          roll = dice.roll
          Console.inform "#{current_player}'s roll: #{roll}"

          score = get_score(roll)
          Console.inform "Score: #{score}"

          current_player.score += score

          if current_player.score >= @play_to
            # END GAME
            Console.inform "#{current_player} is the winner! #{current_player.catchphrase}", "green"
            return
          end
        end
      end

    end
  end


end
