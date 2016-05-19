get '/fxtrans' do
  @fxtrans = Fxtran.all
                   .order('zipcode ASC')
                   .order('curr_buy ASC')
                   .order('curr_sell ASC')
                   .order('size DESC')
  @fxbuys = Fxtran.where(trantype: "BUY")
                   .order('zipcode ASC')
                   .order('curr_buy ASC')
                   .order('curr_sell ASC')
                   .order('size DESC')

  @fxsells = Fxtran.where(trantype: "SELL")
                   .order('zipcode ASC')
                   .order('curr_buy ASC')
                   .order('curr_sell ASC')
                   .order('size DESC')
  erb :'fxtrans/index'
end
