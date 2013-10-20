class Ttodo
  include DataMapper::Resource
  belongs_to :category
  belongs_to :user
  # property <name>, <type>
  property :id, Serial
  property :prio, Integer
  property :thema, Text ,required: true
  property :created_at, DateTime
  property :updated_at, DateTime
  property :done, Integer, required: true
  #validates_with_method :check1
  
  before :save do 
    self.updated_at = Time.now
  end
 
def myCreate(plan) 
	       lim=Ttodo.count(user_id: self.user_id)
         if lim>24 && plan=='F'
	     	self.errors.add( :id, 'Sorry, only 25 todos for free Plan allowed, consider upgrade...')
	     	return false
	    else  	
		        self.created_at = Time.now
		        self.save  
     	end

 end
end
