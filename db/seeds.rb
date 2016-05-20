require 'faker'

User.delete_all
Fxtran.delete_all

users = 10.times.map do
  User.create!( :first_name => Faker::Name.first_name,
    :last_name  => Faker::Name.last_name,
    :email      => Faker::Internet.email,
    :password   => 'password' )
end

5.times do
  random_user = User.all.sample
  available_currency = ["USD", "EUR"]
  cur1 = available_currency.sample
  cur2 = available_currency.reject{|cur| cur == cur1}.sample
  Fxtran.create( requestor_id: random_user.id,
                     trantype: ["BUY", "SELL"].sample,
                       amount: rand(10..51),
                     curr_buy: cur1,
                    curr_sell: cur2,
                       status: "OPEN",
                      zipcode: [14532, 34595].sample )
end

