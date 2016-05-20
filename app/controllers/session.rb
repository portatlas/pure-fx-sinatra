get '/login' do
  erb :'/users/login'
end

post '/login' do
  if user = User.authenticate(params[:user][:email], params[:user][:password])
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    redirect '/login'
  end
end

get '/logout' do
  session.clear

  redirect '/'
end

