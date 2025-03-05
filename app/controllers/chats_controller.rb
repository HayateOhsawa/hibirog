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
      # 非同期通信を使用せず、リダイレクトで処理を終了する
      redirect_to chats_path, notice: 'チャットが送信されました。'
    else
      # エラーメッセージを表示する
      flash.now[:alert] = @chat.errors.full_messages.join(', ')
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
    params.require(:chat).permit(:message_content) # user_idは不要
  end
end
