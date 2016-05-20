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
    Money.default_bank = Money::Bank::GoogleCurrency.new
    @converted_vals = []
    @fx_rates = []
    counter = 0
    while counter < @user.fxrequests.size
      # binding.pry
      @amount = @user.fxrequests[counter].amount
      curr_have = @user.fxrequests[counter].curr_sell
      curr_want = @user.fxrequests[counter].curr_buy
      money = Money.new(@amount * 100, curr_have)
      @converted_val = money.exchange_to(curr_want)
      @converted_vals << @converted_val
      @fx_rates << (@converted_val / @amount)
      counter += 1
    end
    @fx_rates
    @converted_vals

    # binding.pry
    # @amount = @user.fxrequests[0].amount
    # curr_have = @user.fxrequests[0].curr_sell
    # curr_want = @user.fxrequests[0].curr_buy
    # Money.default_bank = Money::Bank::GoogleCurrency.new
    # money = Money.new(@amount * 100, curr_have) # amount is in cents
    # @converted_val = money.exchange_to(curr_want)
    # @fxrate = @converted_val / @amount
    erb :'users/show'
  else
    redirect '/'
  end
end
