get '/fxtrans' do
  @fxtrans = Fxtran.all #define instance variable for view
  erb :'fxtrans/index' #show all fxtrans view (index)
end
