class CreateAmountOfCurrencies < ActiveRecord::Migration
  def change
    create_table :amount_of_currencies do |t|
      t.integer :member_id
      t.integer :currency_id
      t.integer :amount

      t.timestamps
    end
  end
end
