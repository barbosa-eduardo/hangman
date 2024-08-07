# frozen_string_literal: false

# Contains the for generating the secret word
class SecretWorld
  def initialize
    @secret = p File.readlines('google-10000-english-no-swears.txt').sample.chomp
    @discovered = Array.new(secret.length, '_')
  end

  def guess(guess)
    return if won?

    if guess.length > 1
      guess_word(guess.downcase)
    else
      guess_letter(guess.downcase)
    end
    fetch_current_progress
  end

  def fetch_current_progress
    discovered.join(' ')
  end

  def won?
    !discovered.include?('_')
  end

  def reveal
    temp = secret
    reset
    temp
  end

  def reset
    @secret = File.readlines('google-10000-english-no-swears.txt').sample.chomp
    @discovered = Array.new(secret.length, '_')
  end

  private

  attr_accessor :secret, :discovered

  def guess_letter(guess)
    discovered.each_index do |i|
      discovered[i] = guess if secret[i] == guess
    end
  end

  def guess_word(guess)
    self.discovered = (guess == secret ? secret : discovered)
  end
end
