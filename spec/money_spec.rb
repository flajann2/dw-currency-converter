require_relative 'spec_helper'

include DwCurrencyConv

describe Money do
  before(:all) do
    Money.conversion_rates 'EUR', {
                             'USD'     => 1.11,
                             'Bitcoin' => 0.0047,
                             'PHP'     => 53.768438,
                             'PLN'     => 4.34457705
                           }
    @a = Money.new 20, 'EUR'
    @b = Money.new 40, 'USD'
    @fifty_eur = Money.new 50, 'EUR'
    @twenty_dollars = Money.new 20, 'USD'
  end
  
  it "can add two currencies" do
    a_plus_b = @a + @b
    expect(a_plus_b.inspect).to eq("56.04 EUR")
  end

  it "can convert between non-base currencies" do
    from = Money.new 2000, 'PHP'
    to = from.convert_to 'USD'
    expect(to.amount.round(2)).to eq(41.29)
  end

  it "get amount and currency" do
    expect(@fifty_eur.amount).to eq(50)
    expect(@fifty_eur.currency).to eq('EUR')
    expect(@fifty_eur.inspect).to eq('50.00 EUR')
  end

  it "convert to a different currency" do
    expect(@fifty_eur.convert_to('USD').inspect).to eq('55.50 USD')
  end

  it "does arithemetics" do
    expect((@fifty_eur + @twenty_dollars).inspect).to eq('68.02 EUR')
    expect((@fifty_eur - @twenty_dollars).inspect).to eq('31.98 EUR')
    expect((@fifty_eur / 2).inspect).to               eq('25.00 EUR')
    expect((@twenty_dollars * 3).inspect).to          eq('60.00 USD')    
  end

  it "does comparasions" do
    expect(@twenty_dollars == Money.new(20, 'USD')).to be_truthy
    expect(@twenty_dollars == Money.new(30, 'USD')).to be_falsey

    fifty_eur_in_usd = @fifty_eur.convert_to('USD')
    
    expect(fifty_eur_in_usd == @fifty_eur).to          be_truthy
    expect(@twenty_dollars > Money.new(5, 'USD')).to   be_truthy
    expect(@twenty_dollars < @fifty_eur).to             be_truthy
  end

  it "throws an exception if currency is not recognized" do
    expect {
      @twenty_dollars.convert_to('XXX')
    }.to raise_error /Problem with converting EUR to XXX/
  end
end
