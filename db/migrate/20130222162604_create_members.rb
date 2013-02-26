class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :member_id
      t.string :name
      t.string :profile

      t.timestamps
    end
  end
end
