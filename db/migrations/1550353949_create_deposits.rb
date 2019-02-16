Sequel.migration do
  up do
    create_table(:deposits) do
      primary_key :id

      BigDecimal :amount, size: [10, 2]
      DateTime :created_at, null: false

      foreign_key :account_id, :accounts
    end
  end

  down do
    drop_table(:deposits)
  end
end