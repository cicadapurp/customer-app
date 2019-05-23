class CustomersController < ApplicationController
before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    # active record way
    # @customers = current_user.customers
    # SQL way
    @customers = Customer.all_customers(current_user.id)
  end

  def show
  end

  def new
    @customer = current_user.customers.new
  end

  def update
      @customer = Customer.update_customer(@customer.id, customer_params)
  end

  def edit
    
  end

  def create
    #active record way
    # @customer = current_user.customers.new(customer_params)

    #find by SQL
    Customer.create_customer(customer_params, current_user.id)
    redirect_to customers_path
  end
  def destroy
    #find_by_sql
    Customer.delete_customer(@customer.id)
    redirect_to customers_path

  end
  private
  def set_customer
    #active record
    #@customer = current_user.customers.find(params[:id])
    #find by sql
    @customer = Customer.single_customer(current_user.id, params[:id])
  end
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone)

  end

end
