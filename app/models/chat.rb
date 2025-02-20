class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :record, optional: true # optional: true は、record_idがnilでも保存できるようにするため

  validates :message_content, presence: true, length: { maximum: 500 }
end
