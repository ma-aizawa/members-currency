class CreateLogForCurrencies < ActiveRecord::Migration
  def change
    create_table :log_for_currencies do |t|
      t.integer :currency_id
      t.integer :currency
      t.integer :amount
      t.text :log

      t.timestamps
    end
  end
end
