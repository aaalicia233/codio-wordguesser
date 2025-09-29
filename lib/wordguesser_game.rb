require 'httparty'
require 'json'
class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses

  def self.get_random_word
    response = HTTParty.post('http://randomword.saasbook.info/RandomWord')
    response.parsed_response
  end

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  def guess(letter)
    raise ArgumentError if letter.nil? || letter.empty? || !letter.match?(/[a-zA-Z]/)
  
    letter.downcase!
  
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
  
    if @word.include?(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end
  
    return true
  end
  def word_with_guesses
    displayed_word = ''
    @word.each_char do |char|
      if @guesses.include?(char)
        displayed_word << char
      else
        displayed_word << '-'
      end
    end
    displayed_word
  end
  def check_win_or_lose
    if !word_with_guesses.include?('-')
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end
end