require 'rails_helper'

RSpec.describe Sale, :type => :model do

  describe '#fields' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:price_cents).of_type(:integer) }
    it { should have_db_column(:amount).of_type(:integer) }
    it { should have_db_column(:address).of_type(:text) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_column(:shopper_id).of_type(:integer) }
    it { should have_db_column(:product_id).of_type(:integer) }
    it { should have_db_column(:supplier_id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end

  describe '#associations' do
    it { should belong_to(:shopper) }
    it { should belong_to(:product) }
    it { should belong_to(:supplier) }
    it { should belong_to(:user) }
  end

  describe '#validations' do
    it { should validate_presence_of(:price_cents) }
    it { should validate_numericality_of(:price_cents).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:shopper) }
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:supplier) }
    it { should validate_presence_of(:user) }
  end

  describe '#monetizes' do
    it { should monetize(:price_cents) }
  end

  describe '#scopes' do
    let(:account) { create :user }

    context 'ordered by shopper name' do
      let(:product)     { create :valid_product, user: account }
      let(:supplier)    { create :valid_supplier, user: account }

      let(:shopper_one) { create :valid_shopper, name: 'Fulano', user: account }
      let(:shopper_two) { create :valid_shopper, name: 'Beltrano', user: account }

      let(:sale_one)    { create :valid_sale, shopper: shopper_one, product: product, supplier: supplier, user: account }
      let(:sale_two)    { create :valid_sale, shopper: shopper_two, product: product, supplier: supplier, user: account }

      it { expect(described_class.ordered(account)).to match_array([sale_two, sale_one]) }
    end
  end

  describe '#imports' do
    let(:account) { create :user }

    context 'when valid file' do
      let(:file) { attributes_for(:valid_file)[:file] }

      it { expect(described_class.import(file, account)).to be_truthy }
    end

    context 'when invalid file' do
      let(:file) { attributes_for(:invalid_file)[:file] }

      it { expect { described_class.import(file, account) }.to raise_exception(StandardError::TypeError) }
    end
  end

  describe '#factories' do
    it { expect(build :valid_sale).to be_valid }
    it { expect(build :invalid_sale).to_not be_valid }
  end

end
