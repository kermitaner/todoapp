migration 2, :create_categories do
  up do
    create_table :categories do
      column :id, Integer, :serial => true
      column :cat, DataMapper::Property::String, length: 30
    end
  end

  down do
    drop_table :categories
  end
end
