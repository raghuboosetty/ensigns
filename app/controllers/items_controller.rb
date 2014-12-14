class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  # before_filter :process_uploads, only: [:create, :upload]

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
    if params[:item][:uploads].present?
      count = 0
      params[:item][:uploads].each do |file|
        file_name_arr = file.original_filename.split("_")
        if file_name_arr.size >= 3
          item = Item.new photo: file,
                          code: file_name_arr[0],
                          wholesale_price: file_name_arr[1].to_i,
                          size: file_name_arr[2].split(".")[0].downcase,
                          status: "in_stock"
          count += 1 if item.save
          logger.debug "\nCREATED: #{file.original_filename} - #{item.inspect}\n"
        else
          logger.debug "\nSKIPPED: #{file.original_filename}\n"
        end
      end
      # @item = Item.create(item_params)
      redirect_to items_path, notice: "#{count} items created of #{params[:item][:uploads].size}"
    else
      @item = Item.new(item_params)
      @item.save
      respond_with(@item)
    end
  end

  def update
    @item.update(item_params)
    redirect_to @item, notice: "Successfully Updated!"
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "Successfully Deleted!"
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def process_uploads
      if params[:item][:uploads].present?
        params[:item][:uploads].each do |file|
          logger.debug "\nFILE NAME #{file.original_filename}\n"
        end
      end
    end

    def item_params
      params.require(:item).permit(:customer_id, :q, :token, :size, :code, :wholesale_price, :retail_price, :selling_price, :discount, :status, :payment_status, :description, :paid_amount, :photo, :uploads)
    end
end