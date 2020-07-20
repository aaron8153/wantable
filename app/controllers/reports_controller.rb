class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @coupons = Coupon.all
    # Product.with_sales_between_dates(DateTime.strptime(s.to_s, '%s'), e)
    start_date = DateTime.strptime(0.to_s, '%s')
    end_date = Time.now
    @products = Product.includes(:order_items).with_sales_between_dates(start_date, end_date).order(:name).uniq
  end

  def coupon_select
    render partial: "coupon_results", locals: {coupon: Coupon.find(params[:coupon_id])}
  end

  def product_sales
    start_date = DateTime.strptime(params[:start_date], '%s')
    end_date = DateTime.strptime(params[:end_date], '%s')
    products = Product.includes(:order_items).with_sales_between_dates(start_date, end_date).order(:name).uniq
    render partial: "product_sales", locals: {products: products}
  end
end
