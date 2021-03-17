require 'rails_helper'

RSpec.describe Destination, type: :model do
  describe '配送先入力' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      sleep 1
      @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_form).to be_valid
    end
    it 'building_nameは空でも保存できること' do
      @order_form.building_name = ''
      expect(@order_form).to be_valid
    end

    it 'postal_codeが空だと保存できないこと' do
      @order_form.postal_code = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_form.postal_code = '1234567'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)'")
    end
    it 'prefectureを選択していないと保存できないこと' do
      @order_form.prefecture_id = 1
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Prefecture must be other than 1')
    end
    it 'cityは空では保存できないこと' do
      @order_form.city = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("City can't be blank")
    end
    it 'addressは空では保存できないこと' do
      @order_form.address = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Address can't be blank")
    end
    it 'phone_numberが空では保存できないこと' do
      @order_form.phone_number = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが10文字以下では保存できないこと' do
      @order_form.phone_number = '12345'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number not entered correctly')
    end
    it 'phone_numberが全角では保存できないこと' do
      @order_form.phone_number = '１２３４５６７８９０１'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number not entered correctly')
    end
    it 'tokenが空では登録できないこと' do
      @order_form.token = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Token can't be blank")
    end
  end
end
