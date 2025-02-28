class ChatsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @chats = Chat.includes(:user).order(created_at: :desc)
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.build(chat_params)
    if @chat.save
      # 非同期通信の場合はJSON形式で返す
      render json: {
        chat: @chat.as_json(include: { user: { only: [:name, :id] } }),
        current_user_id: current_user.id
      }
    else
      @chats = Chat.includes(:user).order(created_at: :desc)
      render :index
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
