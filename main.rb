# frozen_string_literal: true

require_relative 'lib/game'

game = Game.new
loop do
  game.play
  ans = String.new
  loop do
    puts 'Do you wish to play again? (y/n)'
    ans = gets.chomp.downcase
    break if 'yn'.include? ans
  end
  break if ans == 'n'
end
