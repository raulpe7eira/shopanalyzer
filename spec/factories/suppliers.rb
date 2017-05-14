FactoryGirl.define do

  factory :supplier do
    name { Faker::Name.name }
    user
  end

  factory :valid_supplier, :parent => :supplier

  factory :invalid_supplier, :parent => :supplier do |f|
    f.id   { 999 }
    f.name { nil }
  end

end
