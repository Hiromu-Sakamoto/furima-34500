class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :orders

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: "half-width alphabets or numbers don't exist"
  validates :nickname, presence: true
  with_options presence: true, format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}ａ-ｚＡ-Ｚ０-９]+\z/, message: " full-width doesn't exist" } do
    validates :family_name, presence: true
    validates :first_name, presence: true
    validates :family_name_kana, presence: true
    validates :first_name_kana, presence: true
  end
  validates :birth_day, presence: true
end
