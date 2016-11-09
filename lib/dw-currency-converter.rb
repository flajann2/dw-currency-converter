# coding: utf-8

module DwCurrencyConv
  class Money
    attr :amount, :currency

    def self.conversion_rates base, rate_list
      @@base_currency = base.to_s
      @@rate_list = rate_list.to_h
    end
    
    def initialize amount, currency
      @amount = amount.to_f
      @currency = currency.to_s
    end

    # Add these two objects and yield a third.
    def +(other_money)
      Money.new(self.amount + other_money.amount, self.currency)
    end
    
  end
  
end

