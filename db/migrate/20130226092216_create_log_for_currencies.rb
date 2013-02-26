class CreateLogForCurrencies < ActiveRecord::Migration
  def change
    create_table :log_for_currencies do |t|
      t.integer :currency_id
      t.integer :amount
      t.text :log
      t.integer :from_member_id
      t.integer :to_member_id

      t.timestamps
    end
  end
end
