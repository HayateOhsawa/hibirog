class Chat < ApplicationRecord
  belongs_to :user

  validates :message_content, presence: true, length: { minimum: 1, maximum: 255 }
end
