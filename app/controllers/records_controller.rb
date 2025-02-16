class RecordsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  def index
    # ログインしていないユーザーにはチャット一覧を表示
    unless user_signed_in?
      @chats = Chat.includes(:user).order(created_at: :desc)
      @chat = Chat.new
      render 'chats/index' and return
    end

    # ログインしているユーザーには通常のレコード一覧を表示
    @records = current_user.records.order(created_at: :desc)
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id # current_userからuser_idを設定
    if @record.save
      # 成功した場合、indexページへリダイレクト
      redirect_to root_path
    else
      # 保存に失敗した場合は再度フォームを表示
      render :new, status: :unprocessable_entity
    end
  end

  def show
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

  private

  # ストロングパラメータの設定
  def record_params
    params.require(:record).permit(:title, :description, :emotion, :location, :retention_level_id, :file)
  end

  def set_record
    @record = Record.find(params[:id])
  end
end
