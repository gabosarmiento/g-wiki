class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :email
      t.string :guid
      t.references :user

      t.timestamps
    end
    add_index :sales, :user_id
  end
end
