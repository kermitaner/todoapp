migration 6, :add_fields_to_ttodos do
  up do
      modify_table :ttodos do	
       add_column :user_id, Integer
       #Ttodo.update(user_id: 3)
	end
  end

  down do
	  modify_table :ttodos do	
       drop_column :user_id, Integer
	end
  end
end
