Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id

      String :first_name
      String :last_name
      String :email
      String :username
      String :encrypted_password

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:users)
  end
end