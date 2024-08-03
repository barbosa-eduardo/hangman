# frozen_string_literal: false

require_relative 'secret_word'

# Contains the logic for the game
class Game
  attr_reader :ended, :current_progress, :current_turn

  TURNS_LIMIT = 8
  def initialize
    @secret_word = SecretWorld.new
    @current_turn = 1
    @ended = false
    @current_progress = secret_word
  end

  def play_round
    reset if ended
    print "Turn #{current_turn}: "
    self.current_progress = secret_word.guess(gets.chomp)
    self.current_turn += 1
    puts current_progress
    end_game if (current_turn > TURNS_LIMIT) || secret_word.won?
  end

  def end_game
    puts(secret_word.won? ? 'You won!' : 'You lost!')
    puts "The secret word was #{secret_word.reveal}"
    self.ended = true
  end

  def reset
    secret_word.reset
    self.current_turn = 1
    self.ended = false
  end

  def self.load
    saved_games = Dir.entries('saved_games')[3..]
    return if saved_games.empty?

    filename = fetch_filename(saved_games)
    selected_game = File.read(filename)
    Marshal.load(selected_game)
  end

  def self.fetch_filename(saved_games)
    ans = ''
    loop do
      puts saved_games
      print 'Which game you want to load? '
      ans = gets.chomp
      break if saved_games.include? ans
    end
    "saved_games/#{ans}"
  end

  private

  attr_accessor :secret_word, :guesses_limit, :turn
  attr_writer :ended, :current_turn, :current_progress
end
