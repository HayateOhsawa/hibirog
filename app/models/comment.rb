class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :record
  validates :comment, presence: true, length: { maximum: 500 }
end
