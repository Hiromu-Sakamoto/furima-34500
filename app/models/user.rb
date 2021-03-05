class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :orders

  with_options presence: true do
    validates :nickname
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX, message: "half-width alphabets or numbers don't exist"
    with_options format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}ａ-ｚＡ-Ｚ０-９]+\z/, message: "full-width doesn't exist" } do
      validates :family_name
      validates :first_name
    end
    with_options presence: true,
                 format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: "full-width katakana doesn't exist" } do
      validates :family_name_kana
      validates :first_name_kana
    end
    validates :birth_day
  end
end
