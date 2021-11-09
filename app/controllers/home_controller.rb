class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=c93b03ea-b0d3-4f24-8908-2c2ac8494af0'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @array1 = JSON.parse(@response).to_a
    @array2 =@array1[1].to_a
    
    @coins = @array2[1].to_a
    
  end
  def nosotros
  end
  def lookup
    require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=c93b03ea-b0d3-4f24-8908-2c2ac8494af0'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @array1 = JSON.parse(@response).to_a
    @array2 =@array1[1].to_a
    
    @lookup_coin = @array2[1].to_a
    
  
    @simbolo = params[:sym]

    if @simbolo
      @simbolo = @simbolo.upcase
    end
    if @simbolo == ""
      @simbolo = "Has olvidado escribir la búsqueda"
    end
  end
end
