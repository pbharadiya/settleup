class AddPaymentIdToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_reference :transactions, :payment, foreign_key: true
  end
end
