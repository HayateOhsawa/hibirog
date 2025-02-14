class ChatsController < ApplicationController
  def index
    @record = Record.find(params[:record_id])
    @chats = @record.chats.order(created_at: :desc)
  end

  def new
    @record = Record.find(params[:record_id])
    @chat = Chat.new
  end

  def create
    @record = Record.find(params[:record_id])
    @chat = @record.chats.build(chat_params)
    @chat.user = current_user
    if @chat.save
      redirect_to record_chats_path(@record)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to record_chats_path(@chat.record), notice: 'チャットが削除されました。'
  end
end
