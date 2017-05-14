FactoryGirl.define do

  factory :shopper do
    name { Faker::Name.name }
    user
  end

  factory :valid_shopper, :parent => :shopper

  factory :invalid_shopper, :parent => :shopper do |f|
    f.id   { 999 }
    f.name { nil }
  end

end
