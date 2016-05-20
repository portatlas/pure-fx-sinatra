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

# while the number of fx transactions is greater than zero
# iterate through the fxrequests
# calculate the fx rate and store it in an array of fx rates
# caculate the converted_val and store it in an converted_val array

#

get '/users/:id' do
  @user = User.find(params[:id])
  if @user.id == session[:user_id]
    user_fxrequest = @user.fxrequests

    calculate_rate(user_fxrequest, user_fxrequest)

    erb :'users/show'
  else
    redirect '/'
  end
end

