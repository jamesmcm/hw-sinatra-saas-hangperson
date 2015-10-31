class HangpersonGame
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  attr_accessor :check_win_or_lose  
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses=''
    @wrong_guesses=''
    @word_with_guesses="-"*word.size
    @check_win_or_lose = :play
  end

  def guess(x)
    if (/[A-Z]{1}/.match(x))
      return false
    end
    if (!(/[a-z]{1}/.match(x)))
        raise ArgumentError
    end 
    if self.guesses.include? x or self.wrong_guesses.include? x
      return false
    end
    if self.word.include? x
      self.guesses = self.guesses + x

      self.word.length.times {|i| self.word_with_guesses[i] = self.word[i] if self.word[i]==x}

      if self.word_with_guesses.index('-').nil?
        self.check_win_or_lose = :win
      end
      return(true)
    else
      self.wrong_guesses=self.wrong_guesses + x
      if self.wrong_guesses.size>=7
        self.check_win_or_lose = :lose
      end
      return(true)
    end
  end
    

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
