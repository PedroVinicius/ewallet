Sequel.migration do
  up do
    create_table(:transferences) do
      primary_key :id

      BigDecimal :amount, size: [10, 2], null: false
      DateTime :created_at, null: false

      foreign_key :source_account_id, :accounts, key: :id
      foreign_key :destination_account_id, :accounts, key: :id
    end
  end

  down do
    drop_table(:transferences)
  end
end