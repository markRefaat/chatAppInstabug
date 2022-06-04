class ChatsController < ApplicationController
  before_action :set_application

  # GET /chats
  def index
    @chats = @application.chats.all

    render json: @chats
  end

  # GET /chats/1
  def show
    @chat = @application.chats.find_by(number: params[:number])
    render json: @chat
  end

  # POST /chats
  def create
    # @chat = Chat.new(chat_params)
    
    @chat = @application.chats.new(
      {
        number: @application.chats_count + 1
      }
    )
    @application.chats_count += 1
    @application.save

    if @chat.save
      render json: @chat, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @application.chats.find_by(number: params[:number]).update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @application.chats.find_by(number: params[:number]).destroy
    @application.chats_count -= 1
    @application.save
  end

  private
    def set_application
      @application = Application.find_by(access_token: params[:application_access_token])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:application)
    end
end
