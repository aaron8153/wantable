class OrdersController < ApplicationController
  before_action :find_order!, only: :show

  def index
    @search = Order.ransack(params[:q])
    # make name the default sort column
    @search.sorts = 'number' if @search.sorts.empty?
    @orders = @search.result
                  .includes(:user)
                  .page params[:page]
    @search.build_condition
  end

  def show
  end

  private
  def find_order!
    @order = Order.find_by!(number: params[:number])
  end
end
