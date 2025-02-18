class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :record
  validates :content, presence: true
end
