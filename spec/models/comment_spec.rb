require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.create(:user) # ユーザーを生成
    @record = FactoryBot.create(:record) # Recordを生成
    @comment = FactoryBot.build(:comment, user: @user, record: @record) # コメントを生成
  end

  describe 'コメントの投稿' do
    context 'コメントが正しく入力されている場合' do
      it 'コメントが1文字以上500文字以内の場合は投稿できる' do
        @comment.comment = 'a' * 500  # 500文字のコメント
        expect(@comment).to be_valid
      end
    end

    context 'コメントに不備がある場合' do
      it 'コメントが空では投稿できない' do
        @comment.comment = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Comment can\'t be blank')
      end

      it 'コメントが500文字を超えると投稿できない' do
        @comment.comment = 'a' * 501  # 501文字のコメント
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Comment is too long (maximum is 500 characters)')
      end

      it 'ユーザーが関連付けられていない場合、投稿できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end

      it 'レコードが関連付けられていない場合、投稿できない' do
        @comment.record = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Record must exist')
      end
    end
  end
end
