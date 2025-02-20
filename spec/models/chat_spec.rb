require 'rails_helper'

RSpec.describe Chat, type: :model do
  before do
    @chat = FactoryBot.build(:chat)
  end

  describe 'チャットの投稿' do
    context 'メッセージが正しく入力されている場合' do
      it 'メッセージが1文字以上500文字以内の場合は投稿できる' do
        @chat.message_content = 'a' * 500  # 500文字のメッセージ
        expect(@chat).to be_valid
      end
    end

    context 'メッセージに不備がある場合' do
      it 'メッセージが空では投稿できない' do
        @chat.message_content = nil
        @chat.valid?
        expect(@chat.errors.full_messages).to include('Message content can\'t be blank')
      end

      it 'メッセージが500文字を超えると投稿できない' do
        @chat.message_content = 'a' * 501  # 501文字のメッセージ
        @chat.valid?
        expect(@chat.errors.full_messages).to include('Message content is too long (maximum is 500 characters)')
      end

      it 'ユーザーが関連付けられていない場合、投稿できない' do
        @chat.user = nil
        @chat.valid?
        expect(@chat.errors.full_messages).to include('User must exist')
      end
    end
  end
end
