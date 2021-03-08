class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

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
    validates :category_id, numericality: { other_than: 1 } 
    validates :condition_id, numericality: { other_than: 1 } 
    validates :charges_id, numericality: { other_than: 1 } 
    validates :prefecture_id, numericality: { other_than: 1 } 
    validates :estimated_date_id, numericality: { other_than: 1 } 
    validates :price, numericality: {greater_than: 299, less_than: 10000000}
  end
end