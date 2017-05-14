FactoryGirl.define do

  factory :sale do
    price_cents { Money.new(Random.rand(999)).cents }
    amount      { Random.rand(999) }
    address     { Faker::Lorem.paragraph([2, 3, 4, 5].sample) }
    shopper
    product
    supplier
    user
  end

  factory :valid_sale, :parent => :sale

  factory :invalid_sale, :parent => :sale do |f|
    f.id     { 999 }
    f.amount { nil }
  end

end
