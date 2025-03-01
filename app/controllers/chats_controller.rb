class ChatsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @chats = Chat.includes(:user).order(created_at: :desc)
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.build(chat_params) # 現在のユーザーと関連付けてチャットを作成
    if @chat.save
      # チャットメッセージをブロードキャスト
      ActionCable.server.broadcast 'chat_channel', {
        chat: @chat.as_json(include: { user: { only: [:name, :id] } }), # ユーザー情報を含める
        current_user_id: current_user.id
      }
      # 非同期通信の場合はJSON形式で返す
      render json: {
        chat: @chat.as_json(include: { user: { only: [:name, :id] } }),
        current_user_id: current_user.id
      }, status: :ok
    else
      # エラーメッセージを返す
      render json: { error: @chat.errors.full_messages }, status: :unprocessable_entity
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
    params.require(:chat).permit(:message_content) # user_idは不要
  end
end
