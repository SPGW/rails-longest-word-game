require "json"
require "open-uri"
require 'net/http'

class GamesController < ApplicationController
  def new
    @letters = "";
    10.times.map { @letters << ('a'..'z').to_a[rand(26)] }
  end


  def score
    # check if params[:word] can be built from @letters
    def not_included
      params[:word].chars.all? { |letter| !params[:letters].include?(letter) }
    end
    @not_included = not_included
  # will return false if word can be built from letters
  #  -> if not_included? == "true" -> "Sorry but params[:word] can not be built from @letters"

  #check if params[:word] is a real word
  def isWord
    @uri = URI.parse("https://dictionary.lewagon.com/#{params[:word]}")
    @response = Net::HTTP.get_response(@uri)
    @data = JSON.parse(@response.body)
    @data["found"]
  end
  @isWord = isWord
  # -> if @isWord == false -> "Sorry but params[:word] is not a real word"
  #else
  # -> "Congratulations! params[:word] is a real word!"
  # raise
  end
end
