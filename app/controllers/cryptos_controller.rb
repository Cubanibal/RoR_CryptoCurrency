class CryptosController < ApplicationController
  before_action :set_crypto, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :usuario_correcto, only: %i[ show edit update destroy ]

  # GET /cryptos or /cryptos.json
  def index
    @cryptos = Crypto.all

    require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=c93b03ea-b0d3-4f24-8908-2c2ac8494af0'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @array1 = JSON.parse(@response).to_a
    @array2 =@array1[1].to_a
    
    @lookup_crypto = @array2[1].to_a
    @ganapierde = 0
  end

  # GET /cryptos/1 or /cryptos/1.json
  def show
    require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&CMC_PRO_API_KEY=c93b03ea-b0d3-4f24-8908-2c2ac8494af0'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @array1 = JSON.parse(@response).to_a
    @array2 =@array1[1].to_a
    
    @show_crypto = @array2[1].to_a
  end

  # GET /cryptos/new
  def new
    @crypto = Crypto.new
  end

  # GET /cryptos/1/edit
  def edit
  end

  # POST /cryptos or /cryptos.json
  def create
    @crypto = Crypto.new(crypto_params)

    respond_to do |format|
      if @crypto.save
        format.html { redirect_to @crypto, notice: "Crypto was successfully created." }
        format.json { render :show, status: :created, location: @crypto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptos/1 or /cryptos/1.json
  def update
    respond_to do |format|
      if @crypto.update(crypto_params)
        format.html { redirect_to @crypto, notice: "Crypto was successfully updated." }
        format.json { render :show, status: :ok, location: @crypto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptos/1 or /cryptos/1.json
  def destroy
    @crypto.destroy
    respond_to do |format|
      format.html { redirect_to cryptos_url, notice: "Crypto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crypto
      @crypto = Crypto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crypto_params
      params.require(:crypto).permit(:simbolo, :user_id, :cost_per, :amount_owned)
    end

    def usuario_correcto
      @correcto = current_user.cryptos.find_by(id: params[:id])
      redirect_to cryptos_path, notice: "No está autorizado" if @correcto.nil?
    end
end
