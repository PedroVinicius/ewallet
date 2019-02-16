Sequel.migration do
  up do
    create_table(:banks) do
      primary_key :id

      String :name, null: false
      Integer :code, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:banks)
  end
end