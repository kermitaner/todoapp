migration 4, :add_done_to_ttodos do
  up do
      modify_table :ttodos do	
       add_column :done, Integer
	end
  end

  down do
	modify_table :ttodos do	
		drop_column :done, Integer
  	end
  end
end
