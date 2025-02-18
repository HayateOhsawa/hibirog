class AddRecordIdToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :record_id, :integer
    add_index :chats, :record_id # インデックスを追加（任意）
  end
end
