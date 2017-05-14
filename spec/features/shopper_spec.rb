require 'rails_helper'

RSpec.feature Shopper, :type => :feature do

  scenario 'Show sign in page' do
    visit '/'
    expect(page).to have_text('Entrar')
  end

  # TODO: implement more scenarios

end
