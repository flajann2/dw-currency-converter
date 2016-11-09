require_relative 'spec_helper'

include DwCurrencyConv

describe Money do
  before(:all) do
    Money.conversion_rates 'EUR', {
                             'EUR'     => 1.0,
                             'USD'     => 1.100855,
                             'Bitcoin' => 0.0047,
                             'PHP'     => 53.768438,
                             'PLN'     => 4.34457705
                           }
  end
  
  it "created a money object" do
    expect(Money.new(20.00, 'EUR')).to_not be_nil
  end

  it "can add two currencies" do
    a = Money.new 20, 'EUR'
    b = Money.new 40, 'USD'
    expect(a + b)
  end
end
