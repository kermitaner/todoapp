migration 1, :create_ttodos do
  up do
    create_table :ttodos do
      column :id, Integer, :serial => true
      column :prio, DataMapper::Property::Integer
      column :thema, DataMapper::Property::Text
      column :created_at, DataMapper::Property::DateTime
      column :updated_at, DataMapper::Property::DateTime
    end
  end

  down do
    drop_table :ttodos
  end
end
