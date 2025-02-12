class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  with_options presence: true do
    validates :name
    validates :password, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }, if: -> { password.present? }
    validates :birth_date
    validates :occupation_id, numericality: { other_than: 1, message: 'を選択してください' }
  end
end
