class RemoveRecordFromChats < ActiveRecord::Migration[7.1]
  def change
    remove_reference :chats, :record, null: false, foreign_key: true
  end
end
