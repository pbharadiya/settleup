class Group < ApplicationRecord
  has_and_belongs_to_many :members, class_name: "User", join_table: "groups_members"
  has_many :payments, dependent: :destroy
  has_many :transactions, through: :payments


  validates :name, presence: true

  # deprecated
  def debt_for(user)
    transactions.where("payee_id = ? and payer_id != ?", user.id,user.id).pluck(:amount).reduce(:+)
  end

  # deprecated
  def credit_for(user)
    transactions.where(payee_id: user.id, payer_id: user.id).pluck(:amount).reduce(:+)
  end

  def debt_to(myself, other)
    debt_to_other = transactions.where(payer_id: other.id, payee_id:  myself.id).pluck(:amount).reduce(:+)
  end

  def credit_to(myself, other)
    credit_to_other = transactions.where(payer_id: myself.id, payee_id:  other.id).pluck(:amount).reduce(:+)
  end

  def total_paid_by(user)
    transactions.where(payer_id: user.id).pluck(:amount).reduce(:+)
  end

  def total_spent_by(user)
    transactions.where(payee_id: user.id).pluck(:amount).reduce(:+)
  end
end
