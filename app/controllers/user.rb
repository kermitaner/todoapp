Todo::App.controllers :user do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  get :logout do
  	@title = "Login"
  	@user||=User.new 
  	session[:user]= nil
  	 flash[:error]='Logout successful'
	redirect 'user/login'
  end
  get :login do
  	@title = "Login"
  	@user||=User.new 
	render 'user/login'
  end
  
  put   :register do 
  	@title = "Login"
    @user=params[:user]
    pwd=(params[:user] [:pw])||''
    email=(params[:user] [:email])||''
    if params[:register]
	    rc= reg_user(email, pwd)
	    flash[:error]=rc[1]
	    if rc[0]==true
		 	redirect(url(:todo, :index)) 
	    else
 		  redirect url_for(:user, :login)
		end	   

	end
	rc=check_user(email, pwd)
	flash[:error]=rc[1]
	if rc[0]==true
		 redirect(url(:todo, :index)) 
	else
		redirect url_for(:user, :login)
	end 
	
  end
  


end
