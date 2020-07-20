class Product < ApplicationRecord
  validates_presence_of :name

  validates   :sku,
              presence: true,
              uniqueness: true

  validates   :msrp,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0
              },
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  validates   :cost,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0
              },
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  has_many :order_items,
           as: :source

  scope :with_sales_between_dates, ->(start_date, end_date) {
    joins(:order_items).merge(OrderItem.sold.ordered_between(start_date, end_date)) }
end
