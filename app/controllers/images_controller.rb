class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    if current_user.try(:admin)
      @images = Image.all
    else
      @images = current_user.images
    end
    @shares = current_user.shares
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
    @case_log = CaseLog.find_by_id(params[:case_log_id])
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create

    # upload file first
    uploadFile
    
    # debug see if url has been updated
    print "\n === checking url === \n"
    print params[:image][:url]
    print "\n === done checking url === \n"
    print image_params
    
    @image = Image.new(image_params)

    @case_log = CaseLog.find_by_id(params[:case_log_id])

    @image.case_log = @case_log

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def current_resource
        @current_resource ||= set_image if params[:id]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:url, :title, :description, :case_log_id)
    end

    # take care of the file upload, bind file to the doctor
    # return the url to be used when accessing the file
    def uploadFile
      @case_log = CaseLog.find_by_id(params[:case_log_id])
      
      # filename = sanitize_filename(params[:upload])
      post = DataFile.save(params[:upload], current_user , @case_log)
      
      params[:image][:url] = post

    end

    # clean up the path sent from the browser
    def sanitize_filename(file_name)
      # get only the filename, not the whole path (from IE)
      just_filename = File.basename(file_name) 
      # replace all none alphanumeric, underscore or perioids
      # with underscore
      just_filename.sub(/[^\w\.\-]/,'_') 
    end
end
