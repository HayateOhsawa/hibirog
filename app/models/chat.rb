class Chat < ApplicationRecord
  belongs_to :user
  # belongs_to :record

  validates :message_content, presence: true
end
