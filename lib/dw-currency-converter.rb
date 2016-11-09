# encoding: utf-8

module DwCurrencyConv
  class Money
    attr :amount, :currency

    def self.conversion_rates base, rate_list
      @@base_currency = base.to_s
      @@rate_list = rate_list.to_h
      @@rate_list[base] = 1.0 # to simplify conversion logic
    end
    
    def initialize amount, currency
      @amount = amount.to_f
      @currency = currency.to_s
    end

    def convert_to(currency)
      begin
        if currency == @@base_currency # converting to base currency
          Money.new(self.amount * 1.0 / @@rate_list[self.currency], currency)
          
        elsif self.currency == @@base_currency # converting from the base currency
          Money.new(self.amount * @@rate_list[currency] / 1.0, currency)
          
        else # converting between currencies -- first conver to base, then from base to target
          convert_to(@@base_currency).convert_to(currency)
        end
      rescue => e
        raise "Problem with converting #{self.currency} to #{currency}: #{e}"
      end
    end
    
    # Add these two objects and yield a third.
    def +(other_money)
      Money.new(amount +
                other_money.convert_to(currency).amount,
                self.currency)
    end
    
    def -(other_money)
      Money.new(self.amount -
                other_money.convert_to(self.currency).amount,
                self.currency)
    end
    
    def *(x)
      Money.new(self.amount * x, self.currency)
    end
    
    def /(x)
      Money.new(self.amount / x, self.currency)
    end
    
    def >(other_money)
      self.amount > other_money.convert_to(self.currency).amount
    end
    
    def <(other_money)
      self.amount < other_money.convert_to(self.currency).amount
    end

    def ==(other_money)
      amount.round(2) == other_money.convert_to(currency).amount.round(2)
    end

    def inspect
      "%.2f #{currency}" % [amount.round(2)]
    end
  end  
end
