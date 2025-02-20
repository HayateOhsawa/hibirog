require 'rails_helper'

RSpec.describe Record, type: :model do
  before do
    @record = FactoryBot.build(:record)
  end

  describe '記録の新規投稿' do
    context '記録情報が正しく入力されている場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@record).to be_valid
      end

      it '感情が空でも登録できる' do
        @record.emotion = ''
        expect(@record).to be_valid
      end

      it '場所が空でも登録できる' do
        @record.location = ''
        expect(@record).to be_valid
      end
    end

    context '記録情報に不備があると登録できない' do
      it 'userが紐づいていないと登録できない' do
        @record.user = nil
        @record.valid?
        expect(@record.errors.full_messages).to include('User must exist')
      end

      it 'タイトルが空では登録できない' do
        @record.title = ''
        @record.valid?
        expect(@record.errors.full_messages).to include("Title can't be blank")
      end

      it '説明が空では登録できない' do
        @record.description = ''
        @record.valid?
        expect(@record.errors.full_messages).to include("Description can't be blank")
      end

      it '定着度が空では登録できない' do
        @record.retention_level_id = nil
        @record.valid?
        expect(@record.errors.full_messages).to include('Retention level must be selected')
      end

      it 'タイトルが100文字を超えると登録できない' do
        @record.title = 'a' * 101
        @record.valid?
        expect(@record.errors.full_messages).to include('Title is too long (maximum is 100 characters)')
      end

      it '感情が100文字を超えると登録できない' do
        @record.emotion = 'a' * 101
        @record.valid?
        expect(@record.errors.full_messages).to include('Emotion is too long (maximum is 100 characters)')
      end

      it '場所が100文字を超えると登録できない' do
        @record.location = 'a' * 101
        @record.valid?
        expect(@record.errors.full_messages).to include('Location is too long (maximum is 100 characters)')
      end
    end
  end

  # describe 'アソシエーションテスト' do
  #   it 'ユーザーが紐づいていること' do
  #     association = described_class.reflect_on_association(:user)
  #     expect(association.macro).to eq :belongs_to
  #   end

  #   it 'コメントを多数持っていること' do
  #     association = described_class.reflect_on_association(:comments)
  #     expect(association.macro).to eq :has_many
  #   end

  #   it 'チャットを1つだけ持っていること' do
  #     association = described_class.reflect_on_association(:chat)
  #     expect(association.macro).to eq :has_one
  #   end
  # end

  context '定着度が一定以上であればチャット画面に共有できる' do
    it '定着度が4以上の場合に共有可能となること' do
      @record.retention_level_id = 4
      expect(@record.shareable?).to be_truthy
    end

    it '定着度が4未満の場合に共有不可となること' do
      @record.retention_level_id = 3
      expect(@record.shareable?).to be_falsey
    end
  end
end
