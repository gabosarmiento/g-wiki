class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :wikiname
      t.text :description
      t.text :body
      t.boolean :public

      t.timestamps
    end
  end
end
