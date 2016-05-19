require 'faker'

User.delete_all
Fxtran.delete_all

users = 20.times.map do
  User.create!( :first_name => Faker::Name.first_name,
    :last_name  => Faker::Name.last_name,
    :email      => Faker::Internet.email,
    :password   => 'password' )
end

20.times do
  random_user = User.all.sample
  Fxtran.create( requestor_id: random_user.id,
                     trantype: ["BUY", "SELL"].sample,
                         size: rand(10..51),
                     curr_buy: ["USD", "EUR", "CHF"].sample,
                    curr_sell: ["AUD", "MXN", "THB"].sample,
                       status: "PENDING",
                      zipcode: [14532, 34595, 56706, 78903, 91834].sample )
end

