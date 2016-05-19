get '/fxtrans' do
  @fxtrans = Fxtran.all
                   .order('zipcode ASC')
                   .order('curr_buy ASC')
                   .order('curr_sell ASC')
                   .order('amount DESC')

  @fxbuys = Fxtran.where(trantype: "BUY")
                   .order('zipcode ASC')
                   .order('curr_buy ASC')
                   .order('curr_sell ASC')
                   .order('amount DESC')

  @fxsells = Fxtran.where(trantype: "SELL")
                   .order('zipcode ASC')
                   .order('curr_buy ASC')
                   .order('curr_sell ASC')
                   .order('amount DESC')

  erb :'fxtrans/index'
end

get '/fxtrans/new' do
  erb :'fxtrans/new'
end

