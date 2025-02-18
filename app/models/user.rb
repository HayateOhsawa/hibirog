class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :records
  has_many :chats
  has_many :comments, dependent: :destroy

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}\z/i # 6文字以上
  with_options presence: true do
    validates :nickname
    validates :password, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて6文字以上で設定してください' }, if: -> { password.present? }
    validates :birth_date
  end

  # occupation_idが1だと登録できない
  validates :occupation_id, numericality: { other_than: 1 }
end
