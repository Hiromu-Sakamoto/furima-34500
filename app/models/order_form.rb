class OrderForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :order, :user_id, :item_id


    # ここにバリデーションの処理を書く
    with_options presence: true do
      validates :postal_code,format: { with:/\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)'" } 
      validates :prefecture_id, numericality: { other_than: 1 }
      validates :city
      validates :address
      validates :phone_number,format: { with:/\A\d{10}\z|\A\d{11}\z/, message: "not entered correctly" } 
      # validates :token
    end

    def save
      # 各テーブルにデータを保存する処理を書く
      order = Order.create(user_id: user_id, item_id: item_id)
      Destination.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, phone_number: phone_number, building_name: building_name, order_id: order.id)
    end
end