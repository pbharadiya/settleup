class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:new, :create]
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  def index
    @payments = payment.all
  end

  # GET /payments/1
  def show
  end

  # GET /payments/new
  def new
    @payment = @group.payments.build
    @payment.transactions.build
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  def create
    @payment = @group.payments.build(payment_params)

    if @payment.valid?
      @payment.save

      redirect_to @group, notice: 'payment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /payments/1
  def update
    if @payment.update(payment_params)
      redirect_to @payment, notice: 'payment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy
    redirect_to payments_url, notice: 'payment was successfully destroyed.'
  end

  private

    def set_payment
      @payment = payment.find(params[:id])
    end

    def set_group
      @group = current_user.groups.find(params[:group_id])
    end

    # Only allow a trusted parameter "white list" through.
    def payment_params
      params.require(:payment).permit(
        :amount, :purpose,
        transactions_attributes: [:id, :payer_id, :payee_id]
      )
    end
end
