helpers do

  def calculate_rate(transactions, matching_fx)
    Money.default_bank = Money::Bank::GoogleCurrency.new
    @converted_vals = []
    @fx_rates = []
    counter = 0
    while counter < transactions.size
      @amount = transactions[counter].amount
      money = Money.new(@amount * 100, transactions[counter].curr_sell)
      @converted_val = money.exchange_to(transactions[counter].curr_buy)
      @converted_vals << @converted_val
      @fx_rates << (@converted_val / @amount)

      if matching_fx.length == 0
      else
         @fxmatches = Fxtran.where(curr_sell: matching_fx[counter].curr_buy,
                                    curr_buy: matching_fx[counter].curr_sell,
                                     zipcode: matching_fx[counter].zipcode)
                     .where.not(requestor_id: session[:user_id])
      end
      counter += 1
    end
    @fx_rates
    @converted_vals
  end

end
