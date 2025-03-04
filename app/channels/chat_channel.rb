class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup logic when they are unsubscribed
  end

  def speak(data)
    message = data['message']
    user = current_user # 現在ログインしているユーザーを取得

    # チャットメッセージを作成して保存
    chat = user.chats.create!(message_content: message)

    # チャットメッセージをブロードキャスト
    ActionCable.server.broadcast 'chat_channel', {
      chat: chat.as_json(include: { user: { only: [:name, :id] } }), # ユーザー情報を含める
      current_user_id: user.id
    }
  end
end
