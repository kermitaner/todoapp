Todo::App.controllers :todo do
  
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
    before  do
      if not session[:user]
  	 	redirect_to url_for :user, :login
	  end 
 	end
  get :index do
	@title = "Listing all Entries"
	@cats= getCats()
	session[:fdone]=params[:fdone].to_i if params[:fdone]
	session[:fcat]=params[:fcat].to_i  if params[:fcat]
	@fcat=session[:fcat]||0
	@fdone=session[:fdone]||0
	farr={done: @fdone, user_id: session[:user][:id]  }
	farr[:category_id] =  @fcat if @fcat > 0
	@todos=Ttodo.all(farr).paginate(:page => params[:page], order: :prio, per_page: 5)
 	render 'todo/index'	
  end
  
  
  get :new do
    @title = "Create new Entry"
    @todo = Ttodo.new
    @cats= getCats()
    render 'todo/new'
  end
  
  get :edit, :with => :id do
  	@title = "Edit Entry"
	@cats= getCats()
  	@todo=Ttodo.get(params[:id])
  	if @todo
 		render 'todo/edit'
    else
	  flash[:error] = setmeld(@todo)
	 redirect(url(:todo, :index)) 
    end	

    # url is generated as "/admin/show/#{params[:id]}"
    # url_for(:admin, :show, :id => 5) => "/admin/show/5"
  end # get edit
  
 put :update, :with => :id do
    @title = "Update Entry"
    @todo = Ttodo.get(params[:id])
    if @todo
      if @todo.update(params[:ttodo])
        flash[:success] = "record successfully updated"
        redirect(url(:todo, :index)) 
      else
		 flash.now[:error] = setmeld(@todo)
        render 'todo/edit'
      end
    else
      flash[:warning] = "warning"
      halt 404
    end

  end
  #save new entry
  post :create do
    @todo=Ttodo.new(params[:ttodo])
    @todo.user_id = session[:user][:id]
	if @todo.myCreate((session[:user][:plan])||'F')
		 flash[:success] = "todo successfully created"
		 redirect(url(:todo, :new))
	else	
		 @cats= getCats()
		 flash.now[:error] = setmeld(@todo)
		 render 'todo/new'
	end
  end
  
  get :destroy, :with => :id do
    @title = "Delete Entry"
    todo = Ttodo.get(params[:id])
    if todo
      if todo.destroy
        flash[:success] = 'Todo successfully deleted'
      else
    	flash.now[:error] = setmeld(@todo)
      end
      redirect url(:todo, :index)
    else
      flash[:warning] = "Record #{params[:id]} not found"
		redirect(url(:todo, :index))
    end
  end

end
