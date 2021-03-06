class FileuploadsController < ApplicationController
  before_action :set_fileupload, only: [:show, :edit, :update, :destroy]

  # GET /fileuploads
  # GET /fileuploads.json
  def index
    if user_signed_in?
      if !current_user.first_name?
        redirect_to edit_user_path(current_user)
      end
    end
    params[:direction] ||= "desc"
    params[:sort] ||= "cached_votes_score"
    @fileuploads = Fileupload.includes(:user).order(params[:sort] + " " + params[:direction]).limit(25)
  end

  # GET /fileuploads/1
  # GET /fileuploads/1.json
  def show
    @filedownload = @fileupload.filedownload
    @new_file_download = false
    if (!@filedownload)
      @filedownload = Filedownload.new
      @new_file_download = true
    end
  end

  # GET /fileuploads/new
  def new
    if !user_signed_in?
      redirect_to :root
    end
    @fileupload = Fileupload.new
  end

  # GET /fileuploads/1/edit
  def edit
    if !user_signed_in?
      redirect_to :root
    end
  end

  # POST /fileuploads
  # POST /fileuploads.json
  def create
    if !user_signed_in?
      redirect_to :root
    end
    @fileupload = Fileupload.new(fileupload_params)

    respond_to do |format|
      if @fileupload.save
        format.html { redirect_to @fileupload, notice: 'Fileupload was successfully created.' }
        format.json { render :show, status: :created, location: @fileupload }
      else
        format.html { render :new }
        format.json { render json: @fileupload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fileuploads/1
  # PATCH/PUT /fileuploads/1.json
  def update
    if !user_signed_in?
      redirect_to :root
    else
      if current_user.user?
        redirect_to :root
      end
    end
    respond_to do |format|
      if @fileupload.update(fileupload_params)
        format.html { redirect_to @fileupload, notice: 'Fileupload was successfully updated.' }
        format.json { render :show, status: :ok, location: @fileupload }
      else
        format.html { render :edit }
        format.json { render json: @fileupload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fileuploads/1
  # DELETE /fileuploads/1.json
  def destroy
    if !user_signed_in?
      redirect_to :root
    else
      if current_user.user?
        redirect_to :root
      end
    end
    @fileupload.destroy
    respond_to do |format|
      format.html { redirect_to fileuploads_url, notice: 'Fileupload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fileupload
      @fileupload = Fileupload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fileupload_params
      params.require(:fileupload).permit(:user_id, :filename, :sort, :direction)
    end
end
