class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.string :purpose
      t.integer :payee_id
      t.integer :payer_id

      t.timestamps
    end
  end
end
