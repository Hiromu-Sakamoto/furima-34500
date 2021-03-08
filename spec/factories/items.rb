FactoryBot.define do
  factory :item do
    item_name               {Faker::Lorem.sentence}
    description             {Faker::Lorem.sentence}
    image                   {Faker::Lorem.sentence}
    price                   {Faker::Number.between(from: 300,to: 9999999)}
    category_id             {Faker::Number.between(from: 2,to: 11)}
    condition_id            {Faker::Number.between(from: 2,to: 7)}
    charges_id              {Faker::Number.between(from: 2,to: 3)}
    prefecture_id           {Faker::Number.between(from: 2,to: 48)}
    estimated_date_id       {Faker::Number.between(from: 2,to: 4)}
    association :user 
  end
end