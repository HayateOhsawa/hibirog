class Record < ApplicationRecord
  # has_many :comments
  # has_one :chat
  belongs_to :user
  has_one_attached :file

  with_options presence: true do
    validates :title, length: { maximum: 100 }
    validates :description
    validates :retention_level_id
  end

  # 他のフィールドのバリデーション設定
  validates :title, length: { maximum: 100 }
  validates :emotion, length: { maximum: 100 }
  validates :location, length: { maximum: 100 }
end
