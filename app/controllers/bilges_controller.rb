class BilgesController < ApplicationController
  # require any kind of change and creation of a measure to come through our authenticated api using HMAC 
  # and we skip the CSRF check for these requests
  before_action :require_authenticated_api, only: [:edit, :update, :destroy, :create]
  #before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:edit, :update, :destroy, :create]

  before_action :set_bilge, only: [:show, :edit, :update, :destroy]

  # GET /bilges
  # GET /bilges.json
  def index
    @bilges = Bilge.all
  end

  # GET /bilges/1
  # GET /bilges/1.json
  def show
  end

  # GET /bilges/new
  def new
    @bilge = Bilge.new
  end

  # GET /bilges/1/edit
  def edit
  end

  # POST /bilges
  # POST /bilges.json
  def create
    @bilge = Bilge.new(bilge_params)

    respond_to do |format|
      if @bilge.save
        #TwilioTextMessenger.new("Bilge reading saved.", "PHONE_NUMBER_HERE").call - need to add multiple contact update here
        format.html { redirect_to @bilge, notice: 'Bilge was successfully created.' }
        format.json { render :show, status: :created, location: @bilge }
      else
        format.html { render :new }
        format.json { render json: @bilge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bilges/1
  # PATCH/PUT /bilges/1.json
  def update
    respond_to do |format|
      if @bilge.update(bilge_params)
        format.html { redirect_to @bilge, notice: 'Bilge was successfully updated.' }
        format.json { render :show, status: :ok, location: @bilge }
      else
        format.html { render :edit }
        format.json { render json: @bilge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bilges/1
  # DELETE /bilges/1.json
  def destroy
    @bilge.destroy
    respond_to do |format|
      format.html { redirect_to bilges_url, notice: 'Bilge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bilge
      @bilge = Bilge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bilge_params
      params.require(:bilge).permit(:id, :pump_no, :duration)
    end

    def require_authenticated_api
    @current_probe = Probe.find_by_id(ApiAuth.access_id(request))
    logger.info request.raw_post # needed due to a bug in api_auth
    # if a probe could not be found via the access id or the one found did not authenticate with the data in the request
    # fail the call
    if @current_probe.nil? || !ApiAuth.authentic?(request, @current_probe.secret) 
      flash[:error] = "Authentication required"
      redirect_to bilges_url, :status => :unauthorized
    end
  end 
end
