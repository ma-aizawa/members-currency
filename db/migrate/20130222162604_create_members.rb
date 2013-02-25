class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :id
      t.string :name
      t.string :profile

      t.timestamps
    end
  end
end
