class Record < ApplicationRecord
  # has_many :comments
  # has_one :chat
  belongs_to :user
end
