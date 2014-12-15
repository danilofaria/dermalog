class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]

  # GET /doctors
  # GET /doctors.json
  def index
    @doctors = Doctor.all
  end

  # GET /doctors/1
  # GET /doctors/1.json
  def show
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
  end

  # GET /doctors/1/edit
  def edit
  end

  # POST /doctors
  # POST /doctors.json
  def create
    @doctor = Doctor.new(doctor_params)
    # if params[:password_confirmation] != doctor_params[:password]
    #     redirect_to root_path, notice: "Mensagem enviada! Obrigado por nos contactar."
    #     # format.html { render :new }
    #     return
    # end 

    license_check = LicenseCheck.new

    begin
    license_response = license_check.check_license(@doctor)
    rescue
      flash.now.alert = "Check your internet connection"
      render "new"
      return
    end  

    if license_response != LicenseCheck::VALID_LICENSE
      case license_response
      when LicenseCheck::INVALID_LICENSE
        flash.now.alert = "Invalid license"
      when LicenseCheck::INVALID_STATE
        flash.now.alert = "License issuing state does not correspond to provided license"
      when LicenseCheck::INVALID_NAME
        flash.now.alert = "Doctor name does not correspond to provided license"
      when LicenseCheck::ERROR
        flash.now.alert = "Error checking license, please try again"
      end

      render "new"
      return
    end

    respond_to do |format|
      if @doctor.save
        session[:user_id] = @doctor.id
        # root_url
        format.html { redirect_to @doctor, notice: 'Thank you for signing up!' }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctors/1
  # PATCH/PUT /doctors/1.json
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :edit }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.json
  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: 'Doctor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def current_resource
        @current_resource ||= set_doctor if params[:id]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      begin
        @doctor = Doctor.find(params[:id])
      rescue 
      end
      @doctor
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      params.require(:doctor).permit(:license, :name, :email, :password, :password_confirmation, :state)
    end
end
