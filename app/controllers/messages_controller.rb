class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: %i[ show update destroy ]

  # GET /messages
  def index
    @messages = @chat.messages.all
    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message = @chat.messages.new(
      {
        number: @chat.messages_count + 1,
        content: message_params[:content],
      }
    )
    @chat.messages_count += 1
    @chat.save

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    @chat.messages_count -= 1
    @chat.save
  end

  def search
    render json: Message.search({ content: params[:content], chat_id: @chat.id })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @application = Application.find_by(access_token: params[:application_access_token])
      @chat = Chat.find_by(application: @application, number: params[:chat_number])
    end

    def set_message
      @message = Message.find(params[:message_id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content)
    end
end