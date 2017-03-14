class Transaction < ApplicationRecord
  belongs_to :payment, inverse_of: :transactions

  validates :payer_id, presence: true

  before_save :share_payment


  def share_payment
    self.amount = payment.amount.to_i/payment.transactions.size if payment.transactions.present?
  end
end
