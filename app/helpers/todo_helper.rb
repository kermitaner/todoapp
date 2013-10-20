# Helper methods defined here can be accessed in any controller or view in the application

Todo::App.helpers do
  # def simple_helper_method
  #  ...
  # end
  	def get_logoutlink
	  	# kein logout link auf login seite
	  	return unless session[:user]
		return link_to :logout, url_for(:user, :logout)
	end

  	def get_meld
		meld=' '
	 	if flash[:success]
			meld = flash[:success]
	 	elsif flash[:notice]
			meld = flash[:notice]
	 	elsif flash[:error]
		  meld = flash[:error]
		end
		return meld
		
	end
	
	def setmeld(obj)
		s=obj.errors.full_messages.join(', ')
		s='Fehler aufgetreten' if s.empty?
		return s
	end
	def getCats()
		Category.all(:user_id => session[:user][:id], fields: [:id, :cat] , order: :cat)
	end
end
