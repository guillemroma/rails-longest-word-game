class GamesController < ApplicationController
require "json"
require "open-uri"
attr_accessor :letters_array

  def new
    @letters = ("a".."z").to_a
    @letters_array = []
    count = 0
    until count === 10
      random_number = (rand() * 25).to_i
      @letters_array << @letters[random_number]
      count += 1
      # random =
    end
    return @letters_array
  end

  def score
    @word = params[:word].downcase
    @letters = params[:letters].downcase
    @test = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    @result = JSON.parse(@test)
    @letters = @letters.split()
    @word = @word.split("")
    @checking_array = []
    @word.each do |word, index|
      if @letters.include?(word)
        @checking_array << true
        @store = word
        @letters.delete_at(@letters.index(word))
      else
        @checking_array << false
      end
    end
    if @checking_array.include? (false)
      return @final_result = "The word can’t be built out of the original grid"
    elsif @result["found"] === false
      return @final_result = "The word is valid according to the grid, but is not a valid English word"
    else
      return @final_result = "The word is valid according to the grid and is an English word"
    end
  end

end
