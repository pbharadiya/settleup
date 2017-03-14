class Payment < ApplicationRecord
  belongs_to :group
  has_many :transactions, inverse_of: :payment, dependent: :destroy

  accepts_nested_attributes_for :transactions, allow_destroy: true

  validates :amount, presence:true, numericality: true

  def payer
    transactions.present? && User.find(transactions.first.payer_id)
  end

  def payees
    User.where(id: [transactions.pluck(:payee_id)])
  end
end
