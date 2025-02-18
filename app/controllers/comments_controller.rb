class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record

  def create
    @comment = @record.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @record, notice: 'コメントが投稿されました。'
    else
      redirect_to @record, alert: 'コメントの投稿に失敗しました。'
    end
  end

  def destroy
    @comment = @record.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @record, notice: 'コメントが削除されました。'
    else
      redirect_to @record, alert: 'コメントの削除はできません。'
    end
  end

  private

  def set_record
    @record = Record.find(params[:record_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
