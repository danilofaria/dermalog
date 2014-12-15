class SharesController < ApplicationController
  before_action :set_share, only: [:show, :edit, :update, :destroy]

  # GET /shares
  # GET /shares.json
  def index
    if current_user.try(:admin)
      @shared_with_me = Share.all
    else
      @shared_with_me = current_user.shares
    end
    @shared_by_me = Share.shared_by(current_user)
  end

  # GET /shares/1
  # GET /shares/1.json
  def show
  end

  # GET /shares/new
  def new
    @case_log = CaseLog.find_by_id(params[:case_log_id])
    @share = Share.new
  end

  # GET /shares/1/edit
  def edit
  end

  # POST /shares
  # POST /shares.json
  def create
    @share = Share.new()
    @case_log = CaseLog.find_by_id(params[:case_log_id])
    @share.case_log = @case_log
    email = share_params[:doctor_email]

    if email == ""
      @share.errors.add(:email, "can't be blank")
      render :new
      return 
    end
    doctor = Doctor.find_by_email(email)
    if doctor
      @share.doctor = doctor
    else
      @share.errors[:base] << "There is no doctor with this email address"
      render :new
      return 
    end
    respond_to do |format|
      if @share.save
        format.html { redirect_to @share, notice: 'Case log was successfully shared' }
        format.json { render :show, status: :created, location: @share }
      else
        format.html { render :new }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shares/1
  # PATCH/PUT /shares/1.json
  def update
    respond_to do |format|
      if @share.update(share_params)
        format.html { redirect_to @share, notice: 'Share was successfully updated.' }
        format.json { render :show, status: :ok, location: @share }
      else
        format.html { render :edit }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shares/1
  # DELETE /shares/1.json
  def destroy
    @share.destroy
    respond_to do |format|
      format.html { redirect_to shares_url, notice: 'You are not sharing this Case Log anymore' }
      format.json { head :no_content }
    end
  end

  private
    def current_resource
        @current_resource ||= set_share if params[:id]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_share
      @share = Share.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_params
      params.require(:share).permit(:case_log_id, :doctor_id, :doctor_email)
    end
end
