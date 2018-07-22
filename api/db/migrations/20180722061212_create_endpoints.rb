Hanami::Model.migration do
  change do
    create_table :endpoints do
      primary_key :id

      column :name, String, null: false
      column :url, String
      column :description, String
      column :system_id, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
