get '/login' do
  erb :'/users/login'
end

post '/login' do
  if user = User.authenticate(params[:user][:email], params[:user][:password])
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @login_error = true
    erb :'/users/login', locals: { login_error: @login_error }
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

