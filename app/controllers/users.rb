get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])

  if @user.save
    redirect "/login"
  else
    redirect "/users/new"
  end
end



get '/users/:id' do
  @user = User.find(params[:id])
  if @user.id == session[:user_id]
    @open_user_fxrequest = @user.fxrequests.where(status: "OPEN")
    calculate_rate(@open_user_fxrequest, @open_user_fxrequest)
    # binding.pry
    erb :'users/show'
  else
    redirect '/'
  end
end

get '/users/:user_id/fxtrans/:id/edit' do
  @user = User.find(params[:user_id])
  @fxrequest = @user.fxrequests.find(params[:id])
  erb :'fxtrans/edit'
end

put '/users/:user_id/fxtrans/:id' do
  @user = User.find(params[:user_id])
  @fxtran = @user.fxrequests.find(params[:id])
  if @fxtran.update_attributes(params[:fxtran])
    redirect "/users/#{@user.id}"
  else
    erb :'fxtrans/edit' #show edit fxtrans view again(potentially displaying errors)
  end

end

