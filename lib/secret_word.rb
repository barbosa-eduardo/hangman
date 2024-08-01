# frozen_string_literal: false

# Contains the for generating the secret word
class SecretWorld
  def initialize
    @secret_word = File.readlines('google-10000-english-no-swears.txt').sample.chomp
    @revealed_word = Array.new(secret_word.length, '_')
  end

  def reveal_letter(letter)
    return if letter.nil? || letter.length != 1

    letter = letter.downcase
    secret_word.chars.each_with_index do |char, index|
      revealed_word[index] = letter if letter == char
    end
    revealed_word_string
  end

  def revealed_word_string
    revealed_word.join(' ')
  end

  private

  attr_accessor :secret_word, :revealed_word
end
