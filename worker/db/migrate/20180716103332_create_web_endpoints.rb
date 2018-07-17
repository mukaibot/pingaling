ROM::SQL.migration do
  change do
    create_table :endpoints do
      primary_key :id
      column :host, String, null: false
      column :next_check, DateTime
      column :timeout, Integer, null: false, default: 5
      column :retries, Integer, null: false, default: 3
      column :enabled, TrueClass, null: false, default: true
    end
  end
end
