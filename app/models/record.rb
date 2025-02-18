class Record < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :file
  has_one :chat, dependent: :destroy # Chat モデルとの関連付け (1対1)

  with_options presence: true do
    validates :title, length: { maximum: 100 }
    validates :description
    validates :retention_level_id
  end

  # 他のフィールドのバリデーション設定
  validates :title, length: { maximum: 100 }
  validates :emotion, length: { maximum: 100 }
  validates :location, length: { maximum: 100 }

  def shareable?
    retention_level_id >= 4
  end
end
