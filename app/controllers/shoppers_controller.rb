class ShoppersController < ApplicationController
  before_action :set_shopper, only: [:show, :edit, :update, :destroy]

  # GET /shoppers
  # GET /shoppers.json
  def index
    @shoppers = Shopper.ordered(current_user).page(params[:page])
  end

  # GET /shoppers/new
  def new
    @shopper = Shopper.new
    @shopper.user = current_user
  end

  # GET /shoppers/1/edit
  def edit
  end

  # POST /shoppers
  # POST /shoppers.json
  def create
    @shopper = Shopper.new(shopper_params)
    @shopper.user = current_user

    respond_to do |format|
      if @shopper.save
        format.html { redirect_to shoppers_path, notice: 'messages.created' }
        format.json { render :show, status: :created, location: @shopper }
      else
        format.html { render :new }
        format.json { render json: @shopper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoppers/1
  # PATCH/PUT /shoppers/1.json
  def update
    respond_to do |format|
      if @shopper.update(shopper_params)
        format.html { redirect_to shoppers_path, notice: 'messages.updated' }
        format.json { render :show, status: :ok, location: @shopper }
      else
        format.html { render :edit }
        format.json { render json: @shopper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shoppers/1
  # DELETE /shoppers/1.json
  def destroy
    @shopper.destroy
    respond_to do |format|
      format.html { redirect_to shoppers_url, notice: 'messages.destroyed' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopper
      @shopper = Shopper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shopper_params
      params.require(:shopper).permit(:name)
    end
end
