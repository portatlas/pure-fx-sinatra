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
    erb :'users/show'
  else
    redirect '/'
  end
end
