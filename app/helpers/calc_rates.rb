helpers do

  def calculate_rate(transactions, matching_fx)
    Money.default_bank = Money::Bank::GoogleCurrency.new
    @converted_vals = []
    @fx_rates = []
    @target_cpty_difference = []
    @cpty_fx_rates = Array.new
    @cpty_converted_vals = Array.new
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
        matches_count = 0
        while matches_count < @fxmatches.length
        @cpty_amount = @fxmatches[matches_count].amount
        money = Money.new(@cpty_amount * 100, @fxmatches[matches_count].curr_sell)
        @cpty_converted_val = money.exchange_to(@fxmatches[matches_count].curr_buy)
        @cpty_converted_vals << (@cpty_converted_val.to_f)
        @cpty_fx_rates << ((@cpty_converted_val / @cpty_amount)).round(2)
        @target_cpty_difference << (@amount - @cpty_converted_vals[matches_count]).to_d
        matches_count += 1
        # binding.pry
        end
      end
      counter += 1
    end
    @fx_rates
    @converted_vals
  end

end
