class ChatsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @chats = Chat.includes(:user).order(created_at: :desc)
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.build(chat_params)
    @chat.user = current_user
    if @chat.save
      redirect_to chats_path
    else
      @chats = Chat.includes(:user).order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    if @chat.user == current_user
      @chat.destroy
      redirect_to chats_path, notice: 'チャットが削除されました。'
    else
      redirect_to chats_path, alert: '他のユーザーのチャットは削除できません。'
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message_content)
  end
end
