require_relative 'spec_helper'

include DwCurrencyConv

describe Money do
  before(:all) do
    Money.conversion_rates 'EUR', {
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

  it "can convert between non-base currencies" do
    from = Money.new 2000, 'PHP'
    to = from.convert_to 'USD'
    expect((to.amount * 100).floor).to eq(3719)
  end
  
end
