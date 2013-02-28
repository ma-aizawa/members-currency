class AddDateToLog < ActiveRecord::Migration
  def change
    add_column :log_for_currencies, :operation_date, :datetime
  end
end
