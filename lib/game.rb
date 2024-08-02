# frozen_string_literal: true

require_relative 'secret_word'

# Contains the logic for the game
class Game
  TURNS_LIMIT = 8
  def initialize
    @secret_word = SecretWorld.new
  end

  def play
    puts
    TURNS_LIMIT.times do |i|
      print "Turn #{i + 1}: "
      play_round
      break if secret_word.won?
    end
    end_game
  end

  def play_round
    secret_word.guess(gets.chomp)
    puts secret_word.show_discovered_letters unless secret_word.won?
  end

  def end_game
    puts(secret_word.won? ? 'You won!' : 'You lost!')
    puts "The secret word was #{secret_word.reveal}"
  end

  private

  attr_accessor :secret_word, :guesses_limit
end
