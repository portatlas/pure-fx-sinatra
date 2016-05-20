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
    @fx_mathces = []
    counter = 0
    while counter < @user.fxrequests.size
      @amount = @user.fxrequests[counter].amount
      money = Money.new(@amount * 100, @user.fxrequests[counter].curr_sell)
      @converted_val = money.exchange_to(@user.fxrequests[counter].curr_buy)
      @converted_vals << @converted_val
      @fx_rates << (@converted_val / @amount)

      @fxmatches = Fxtran.where(curr_sell: @user.fxrequests[counter].curr_buy,
                                 curr_buy: @user.fxrequests[counter].curr_sell,
                                 zipcode: @user.fxrequests[counter].zipcode)
      counter += 1
    end
    @fx_rates
    @converted_vals

    erb :'users/show'
  else
    redirect '/'
  end
end

