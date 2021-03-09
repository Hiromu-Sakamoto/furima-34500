require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/test_image.png')
  end

  describe '出品登録' do
    context '出品登録できるとき' do
      it 'item_nameとdescriptionとcategory_idと
          condition_idとcharges_idとprefecture_idとestimated_date_idとimageとpriceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'priceが300以上であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが9,999,999以下であれば登録できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end
    context '出品登録できないとき' do
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idが1であるとき登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'condition_idが1であるとき登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end
      it 'charges_idが1であるとき登録できない' do
        @item.charges_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Charges must be other than 1')
      end
      it 'prefecture_idが1であるとき登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'estimated_date_idが1であるとき登録できない' do
        @item.estimated_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Estimated date must be other than 1')
      end
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角数字以外では登録できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角英数混合では登録できない' do
        @item.price = '000AAA'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角英語だけでは登録できない' do
        @item.price = 'AAAAAA'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが300以下では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 299')
      end
      it 'priceが9,999,999以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 10000000')
      end
    end
  end
end
