class ChatsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
     @chats = Chat.for_user(current_user)
  end

  def show
    @chat = Chat.find(params[:id])
  end

  def new
    @chat = Chat.new
  end
  
  def create
    @chat = Chat.new(chat_params)
    @chat.owner = current_user
    @chat.users << @chat.sender unless @chat.users.include?(@chat.sender)
    @chat.users << @chat.receiver unless @chat.users.include?(@chat.receiver)

    if @chat.save
      redirect_to chats_path, notice: 'Chat creado correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  
  def edit
    @chat = Chat.find(params[:id])
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
     redirect_to @chat, notice: 'Chat updated successfully.'
    else
      render :edit
    end
  end

  private
  
  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end


