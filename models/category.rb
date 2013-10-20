class Category

  include DataMapper::Resource
 has n, :ttodos
 belongs_to :user
  # property <name>, <type>
  property :id, Serial
  property :cat, String, length: 30, unique: :user_id
   
  #property :user_id, unique_index: true


def myCreate(plan) 
	      lim=Category.count(user_id: self.user_id)

         if lim>5 && plan=='F'
	     	self.errors.add( :id, 'Sorry, only 6 Categories for free Plan allowed, consider upgrade...')
	     	return false
	    else  	
			self.save 
     	end
end
end
