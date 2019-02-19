class Account < Sequel::Model(:accounts)
  many_to_one :user

  one_to_many :deposits
  one_to_many :withdrawals

  def balance
    deposits = self.deposits_dataset.sum(:amount) || 0
    withdrawals = self.withdrawals_dataset.sum(:amount) || 0

    deposits - withdrawals
  end

  def deposit(amount)
    self.add_deposit(amount: amount)
  end

  def withdraw(amount)
    raise NotEnoughtBalanceError if amount > balance

    self.add_withdrawal(amount: amount)
  end

  def before_update
    check_for_changes!
    super
  end

  private
  def check_for_changes!
    raise NothingChangedError unless self.modified?
  end
end