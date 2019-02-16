Sequel.migration do
  up do 
    create_table(:accounts) do
      primary_key :id

      Integer :number
      String :name

      DateTime :created_at
      DateTime :updated_at

      foreign_key :bank_id, :banks, type: 'INTEGER'
      foreign_key :user_id, :users, type: 'INTEGER'
    end
  end

  down do
    drop_table(:accounts)
  end
end