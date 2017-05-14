include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :file do
    file { fixture_file_upload("#{::Rails.root}/spec/fixtures/files/data.txt", 'text/plain') }
  end

  factory :valid_file, :parent => :file

  factory :invalid_file, :parent => :file do |f|
    file { fixture_file_upload("#{::Rails.root}/spec/fixtures/files/data.csv", 'text/csv') }
  end

end
