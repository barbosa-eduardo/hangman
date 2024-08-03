# frozen_string_literal: true

require_relative 'lib/game'

def input(string, options)
  loop do
    print string
    ans = gets.chomp.downcase
    return ans if options.include?(ans)
  end
end

load_game = if Dir.entries('saved_games')[3..].empty?
              'n'
            else
              input('Do you wish to load a saved game? (y/n) ', %w[y n])
            end
game = (load_game == 'y' ? Game.load : Game.new)
puts game.current_progress
loop do
  game.play_round

  save = input('Do you wish to save the game? (y/n) ', %w[y n]) unless game.ended
  if save == 'y'
    serialized_game = Marshal.dump(game)
    filename = "saved_games/#{Dir.entries('saved_games').length - 1}"
    File.open(filename, 'w') do |file|
      file.print serialized_game
    end
    break
  end

  next unless game.ended

  ans = input('Do you wish to play again? (y/n) ', %w[y n])
  break if ans == 'n'
end
