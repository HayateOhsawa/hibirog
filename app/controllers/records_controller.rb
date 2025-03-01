class RecordsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_record, only: [:show, :edit, :update, :destroy, :share]
  before_action :authorize_user!, only: [:edit, :update, :destroy, :share]

  def index
    if user_signed_in?
      # 検索キーワードがある場合、キーワードでフィルタリング
      @records = if params[:keyword].present?
                   current_user.records.where('title LIKE ? OR description LIKE ?', "%#{params[:keyword]}%",
                                              "%#{params[:keyword]}%")
                 else
                   # 検索がない場合、全てのレコードを表示
                   current_user.records.order(created_at: :desc)
                 end
    else
      @chats = Chat.includes(:user).order(created_at: :desc)
      @chat = Chat.new
      render 'chats/index' and return
    end
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id # current_userからuser_idを設定
    if @record.save
      @record.add_tags(params[:tags])
      redirect_to root_path
    else
      # 保存に失敗した場合は再度フォームを表示
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # 投稿者自身は無条件で閲覧可能
    return if @record.user == current_user

    # 他人のレコードの場合、条件を満たすか確認
    return if @record.retention_level_id >= 4 && Chat.exists?(record_id: @record.id)

    flash[:alert] = 'このレコードは閲覧できません。'
    redirect_to root_path
  end

  def edit
  end

  def update
    if @record.update(record_params)
      redirect_to @record
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
    redirect_to records_path
  end

  def share
    @record = Record.find(params[:id])
    if @record.shareable?
      @chat = Chat.new(user_id: current_user.id, message_content: generate_chat_message(@record))
      @chat.record_id = @record.id
      @chat.save!
      redirect_to chats_path, notice: 'レコードをチャットに共有しました。'
    else
      redirect_to @record, alert: 'このレコードはチャットに共有できません。'
    end
  end

  private

  def record_params
    params.require(:record).permit(:title, :description, :emotion, :location, :retention_level_id, :file_data)
  end

  def set_record
    @record = Record.find(params[:id])
  end

  def generate_chat_message(record)
    message = ''
    message += "タイトル：#{record.title}<br>"
    message += "説明：#{record.description}<br>"
    message += "そのときの感情：#{record.emotion}<br>" if record.emotion.present?
    message
  end

  def authorize_user!
    # 投稿者と現在のユーザーが一致しなければリダイレクト
    return if @record.user == current_user

    flash[:alert] = 'アクセスできません。'
    redirect_to record_path(@record)
  end
end
