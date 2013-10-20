migration 3, :add_categoryid_to_ttodo do
  up do
    modify_table :ttodos do	
       add_column :category_id, Integer
	end
  end

  down do
    modify_table :ttodos do	
       drop_column :category_id, Integer
	end
  end
end
