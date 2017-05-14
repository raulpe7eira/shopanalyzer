FactoryGirl.define do

  factory :product do
    name { Faker::Name.name }
    user
  end

  factory :valid_product, :parent => :product

  factory :invalid_product, :parent => :product do |f|
    f.id   { 999 }
    f.name { nil }
  end

end
