class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show update destroy ]

  # GET /applications
  def index
    @applications = Application.all
    render json: @applications
  end

  # GET /applications/abcd1234
  def show
    @application = Application.find_by(access_token: params[:access_token])
    render json: @application
  end

  # POST /applications
  def create
    @application = Application.new(application_params)
    if @application.save
      render json: @application, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    @application = Application.find_by(access_token: params[:access_token])
    if @application.update(application_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find_by(access_token: params[:access_token])
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(:name)
    end
end
