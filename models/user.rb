class User
  include DataMapper::Resource
  has n, :ttodos
  has n, :categories
  # property <name>, <type>
  property :id, Serial
  property :email, String, unique: true, required: true
  property :pw, String 
  property :plan, String, length: 1, required: true
  property :laccess, DateTime
  property :registered, Date

 def initialize(*)
    super
     self.plan = 'F' 
  end

  before :create do 
    self.registered = Time.now  
    self.laccess = Time.now  
  end
  def del_deep()
     self.ttodos.destroy
     self.categories.destroy
     self.destroy
  end
  
end
