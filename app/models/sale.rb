require 'csv'
require 'monetize'

class Sale < ApplicationRecord
  belongs_to :shopper
  belongs_to :product
  belongs_to :supplier
  belongs_to :user

  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user, presence: true
  validates :shopper, presence: true
  validates :product, presence: true
  validates :supplier, presence: true

  monetize :price_cents

  scope :ordered, -> (current_user) { includes(:shopper).where(user: current_user).order('shoppers.name') }
  scope :summed, -> (current_user) { Money.new(self.where(user: current_user).sum(:price_cents)) }

  paginates_per 10

  def self.import(file_io, current_user)
    raise StandardError::TypeError unless permit_type? file_io, 'text/plain'

    sales = []

    CSV.read(file_io.tempfile, headers: true, col_sep: "\t").each do |row|
      ActiveRecord::Base.transaction do
        shopper = Shopper.find_or_create_by(
          name: row[0],
          user: current_user
        )

        product = Product.find_or_create_by(
          name: row[1],
          user: current_user
        )

        supplier = Supplier.find_or_create_by(
          name: row[5],
          user: current_user
        )

        sale = Sale.find_or_create_by(
          price_cents: Monetize.parse(row[2]).cents,
          amount: row[3].to_i,
          address: row[4],
          shopper: shopper,
          product: product,
          supplier: supplier,
          user: current_user
        )

        sales << sale
      end
    end

    sales.present?
  end

  private
    def self.permit_type?(file_io, content_type)
      file_io.content_type == content_type
    end
end
