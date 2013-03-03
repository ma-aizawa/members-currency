class CreateMoneyTickets < ActiveRecord::Migration
  def change
    create_table :money_tickets do |t|
      t.integer :ticket_id
      t.integer :currency_id
      t.integer :amount
      t.string :status
      t.datetime :used_date
      t.datetime :expire_date

      t.timestamps
    end
  end
end
