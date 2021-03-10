class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :charges
  belongs_to :prefecture
  belongs_to :estimated_date

  with_options presence: true do
    validates :image
    validates :item_name
    validates :description
    validates :price, numericality: { greater_than: 299, less_than: 10_000_000 }
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :charges_id
      validates :prefecture_id
      validates :estimated_date_id
    end
  end
end
