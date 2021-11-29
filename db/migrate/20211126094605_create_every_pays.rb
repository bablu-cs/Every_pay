class CreateEveryPays < ActiveRecord::Migration[6.1]
  def change
    create_table :every_pays do |t|
      t.string :status
      t.string :amount
      t.string :response

      t.timestamps
    end
  end
end
