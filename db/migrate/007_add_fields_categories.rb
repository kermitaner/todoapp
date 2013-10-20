migration 7, :add_fields_categories do
  up do
      modify_table :categories do	
       add_column :user_id, Integer
	end
	#Category.update(user_id: 3)
  end

  down do
	  modify_table :categories do	
       drop_column :user_id, Integer
	end
  end
end
