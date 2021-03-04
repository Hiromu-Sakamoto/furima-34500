require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemailとpasswordとpassword_confirmationと
          family_nameとfirst_nameとfamily_name_kanaとfirst_name_kanaとbirth_dayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailに@が含まれていれば登録できる' do
        @user.email = 'aaa@aaa'
        expect(@user).to be_valid
      end
      it 'emailに一意性があれば登録できる' do
        @user.save
        @user = FactoryBot.build(:user)
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であり、半角英数字ならば登録できる' do
        @user.password = '000AAA'
        @user.password_confirmation = '000AAA'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが@が含まれていなければ登録できない' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailが存在すれば登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字以下では登録できない' do
        @user.password = '000AA'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password half-width alphabets or numbers don't exist")
      end
      it 'passwordが英字だけでは登録できない' do
        @user.password = 'AAAAAA'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password half-width alphabets or numbers don't exist")
      end
      it 'passwordが半角でなければ登録できない' do
        @user.password = '０００ＡＡＡ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password half-width alphabets or numbers don't exist")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'family_nameが全角でなければ登録できない' do
        @user.family_name = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name  full-width doesn't exist")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが全角でなければ登録できない' do
        @user.first_name = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name  full-width doesn't exist")
      end
      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'family_nameが全角でなければ登録できない' do
        @user.family_name = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name  full-width doesn't exist")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaが全角でなければ登録できない' do
        @user.first_name_kana = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana  full-width doesn't exist")
      end
      it 'birth_dayが空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
