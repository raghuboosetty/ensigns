class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :stats]

  respond_to :html

  def index
    @customers = Customer.all
    respond_with(@customers)
  end

  def show
    respond_with(@customer)
  end

  def new
    @customer = Customer.new
    respond_with(@customer)
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: "Successfully Created!"
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Successfully Updated!"
    else
      render :edit
    end
  end
  
  def stats
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: "Successfully Deleted!"
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:name, :email, :phone)
    end
end
