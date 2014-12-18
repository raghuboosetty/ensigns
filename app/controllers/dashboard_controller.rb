class DashboardController < ApplicationController
  def index
    @cost = {
      total: Item.cost,
      earned: Item.earned,
      pending: Item.pending,
      target: Item.target }
    @item = {
      total: Item.count,
      sold: Item.sold.count,
      in_stock: Item.in_stock.count,
      reserved: Item.reserved.count,
      damaged: Item.damaged.count }
  end
end
