class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.string :purpose
      t.references :group

      t.timestamps
    end
  end
end
