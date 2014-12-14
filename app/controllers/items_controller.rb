class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:q]
      q = params[:q]
      @items = Item.where("code LIKE ? OR 
                           wholesale_price LIKE ? OR
                           selling_price LIKE ? OR
                           retail_price LIKE ? OR
                           paid_amount LIKE ? OR
                           token LIKE ?", "%#{q}%", "%#{q}%", "%#{q}%", "%#{q}%", "%#{q}%", "%#{q}%")
    else
      @items = Item.all
    end

    respond_with(@items)
  end

  def show
    respond_with(@item)
  end

  def new
    @item = Item.new
    respond_with(@item)
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.save
    respond_with(@item)
  end

  def update
    @item.update(item_params)
    respond_with(@item)
  end

  def destroy
    @item.destroy
    respond_with(@item)
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:customer_id, :q, :token, :size, :code, :wholesale_price, :retail_price, :selling_price, :discount, :status, :payment_status, :description, :paid_amount, :photo)
    end
end