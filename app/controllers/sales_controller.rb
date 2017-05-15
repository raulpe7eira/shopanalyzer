class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :set_shopper_all, only: [:new, :edit, :create, :update]
  before_action :set_product_all, only: [:new, :edit, :create, :update]
  before_action :set_supplier_all, only: [:new, :edit, :create, :update]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.ordered(current_user).page(params[:page])
    @total = Sale.summed(current_user)
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @sale.user = current_user
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales/import
  def import
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    @sale.user_id = current_user.id
    respond_to do |format|
      if @sale.save
        format.html { redirect_to sales_path, notice: 'messages.created' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sales_path, notice: 'messages.updated' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'messages.destroyed' }
      format.json { head :no_content }
    end
  end

  # POST /sales/upload
  def upload
    respond_to do |format|
      if Sale.import(file_params, current_user)
        format.html { redirect_to sales_path, notice: 'messages.uploaded' }
      else
        format.html { render :import, alert: 'messages.uploaded' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Define all shoppers
    def set_shopper_all
      @shopper_all = Shopper.ordered(current_user)
    end

    # Define all products
    def set_product_all
      @product_all = Product.ordered(current_user)
    end

    # Define all suppliers
    def set_supplier_all
      @supplier_all = Supplier.ordered(current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:price, :amount, :address, :shopper_id, :product_id, :supplier_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_params
      params.require(:file)
    end
end
