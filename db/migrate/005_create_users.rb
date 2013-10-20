migration 5, :create_users do
  up do
    create_table :users do
      column :id, Integer, :serial => true
      column :email, DataMapper::Property::String
      column :pw, DataMapper::Property::String
      column :plan, DataMapper::Property::String, :length => 1
      column :laccess, DataMapper::Property::DateTime
      column :registered, DataMapper::Property::Date
    end
  end

  down do
    drop_table :users
  end
end
