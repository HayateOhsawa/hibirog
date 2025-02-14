class ChatsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  # ユーザーがログインしているか確認（Deviseを使用している場合）

  def index
    @chats = Chat.includes(:user).order(created_at: :desc)
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.build(chat_params)
    if @chat.save
      redirect_to chats_path, notice: 'チャットが正常に作成されました。'
    else
      render :new, status: :unprocessable_entity
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
