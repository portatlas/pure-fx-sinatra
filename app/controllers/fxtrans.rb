get '/fxtrans' do
  @fxtrans = Fxtran.all
                   .order('zipcode ASC')
                   .order('curr_buy ASC')
                   .order('curr_sell ASC')
                   .order('amount DESC')
  calculate_rate(@fxtrans, [])

  erb :'fxtrans/index'
end

get '/fxtrans/new' do
  erb :'fxtrans/new'
end

post '/fxtrans' do
  #below works with properly formatted params in HTML form
  @fxtran = Fxtran.new(params[:fxtran]) #create new fxtran
  if @fxtran.save #saves new fxtran or returns false if unsuccessful
    redirect '/fxtrans' #redirect back to fxtrans index page
  else
    erb :'fxtrans/new' # show new fxtrans view again(potentially displaying errors)
  end

end

