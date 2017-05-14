require 'faker'

RSpec.configure do |config|

  config.before(:suite) do
    Faker::Config.locale = :'pt-BR'
  end

end
