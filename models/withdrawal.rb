class Withdrawal < Sequel::Model(:withdrawals)
  many_to_one :account

  def validate
    super

    errors.add(:amount, "can't be empty") if is_amount_nil?
  end

  def amount
    values[:amount].to_f
  end

  private
  def is_amount_nil?
    self.amount.nil?
  end
end