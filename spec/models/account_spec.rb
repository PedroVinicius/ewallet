require_relative '../spec_helper'

describe Account do
  before(:example) do
    @account = Account.create(name: "John Doe's account", number: 77789)
  end

  context 'when sending money to an account' do
    describe '#deposit' do
      it 'increases the balance value' do
        @account.deposit(100)

        expect(@account.balance.to_f).to be(100.0)
      end
    end
  end

  context 'when doing a withdrawal from an account' do
    describe '#withdraw' do
      it 'decreases the balance value' do
        @account.deposit(100)
        @account.withdraw(50)

        expect(@account.balance.to_f).to be(50.0)
      end
    end
  end

  context 'when balance is not enought to conclude a transaction' do
    it 'raises an error' do
      expect { @account.withdraw(5000) }.to raise_exception(NotEnoughtBalanceError, 'Your balance is not enought to complete this transaction.')
    end
  end
end