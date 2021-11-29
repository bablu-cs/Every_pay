class ChangeColumnNameToTable < ActiveRecord::Migration[6.1]
    def change
      rename_column :every_pays, :response, :payment_reference
    end
end
