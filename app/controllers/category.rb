Todo::App.controllers :category do
      before  do
      if not session[:user]
  	 	redirect_to url_for :user, :login
	  end 
 	end
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
  
   get :index do
     @title = "Listing all Categories"
   	 #@categories=getCats()
   	 @categories=Category.all(user_id: session[:user][:id], fields: [:id, :cat] , order: :cat).paginate(:page => params[:page], order: :cat, per_page: 10)
     render 'category/index'
  end

  get :edit, with: :id do
   'cat edit'
  end
  put :update do
    p params
    id=(params[:category] [:id]).to_i
   cat=params[:category] [:cat]
  	if id==0
    	@cat=Category.new(cat: cat)
    	@cat.user_id= session[:user][:id]
		if @cat.myCreate((session[:user][:plan])||'F')
		 	flash[:success] = "Category successfully created"
		else	
		 	flash[:error] = setmeld(@cat)
		end
	else
    	@cat = Category.get(params[:category] [:id])
    	if @cat
      		if @cat.update({cat: cat})
       			 flash[:success] = "Category successfully updated"
      		else
		 		flash[:error] = setmeld(@cat)
      		end
    	else
      		flash[:warning] = "warning"
    	end
	end

   redirect url(:category, :index)
  end

  get :destroy, :with => :id do
    @title = "Delete Category"
    if 	 Ttodo.first({category_id: params[:id] , user_id: session[:user][:id]})
		 flash[:error] = 'Delete linked Todos first !!'
	     redirect url(:category, :index)

	end

    @cat = Category.get(params[:id])
    if @cat
      if @cat.destroy
        flash[:success] = 'Category successfully deleted'
      else
    	flash[:error] = setmeld(@cat)
      end
    else
      flash[:warning] = "Satz #{params[:id]} nicht gefunden"
    end
    redirect url(:category, :index)
  end
end
#    @todo=Ttodo.new(params[:ttodo])
#	if @todo.save
#		 flash[:success] = "Satz erfolgreich angelegt"
#		 redirect(url(:todo, :index))
#	else	
#		 flash.now[:error] = setmeld(@todo)
#		 render 'todo/new'
#	end