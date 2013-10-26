# Helper methods defined here can be accessed in any controller or view in the application

Todo::App.helpers do

  def check_login_parms(email, pwd)
	  if email.empty?
		  return [false, 'Email missing/invalid !!']
	  end 	  

	  if pwd.size< 8
		  return [false, 'Password too short (min. 8 characters please !)']
	  end 	  
      return [true,nil]
  end
  def reg_user(email, pwd)
	  rc=check_login_parms(email,pwd)
	  return rc unless rc[0]
      
      u=User.new(email: email)
      u.pw = BCrypt::Password.create(pwd)
      if u.save
	    session[:user]={id: u.id , plan: u.plan}
	  	return [true, 'Register successful !!']
	  else
		return [false, setmeld(u)]
	  end
	end 

	def check_user(email, pwd)
		rc=check_login_parms(email,pwd)
	  	return rc unless rc[0]==true
		u=User.first(email: email)
		if u
			if BCrypt::Password.new(u.pw)==pwd
  				session[:user]={id: u.id , plan: u.plan}
  				u.laccess=Time.now
  				u.save
  				return [true,'Login successful !!']
			end
		end
		return [false,'Login unsuccessful !!']
	end	
	
  # def simple_helper_method
  #  ...
  # end
end
