FactoryBot.define do
  factory :destination do
    postal_code          { 123 - 4567 }
    prefecture_id        { 2 }
    city                 { '横浜市緑区' }
    address              { '青山1-1-1' }
    building_name        { '柳ビル103' }
    phone_number         { 12_345_678_901 }
  end
end