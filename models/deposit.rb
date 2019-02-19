class Deposit < Sequel::Model(:deposits)
  many_to_one :account

  def validate
    super

    errors.add(:amount, "can't be empty") if is_amount_nil?
    errors.add(:amount, "needs to be greater than 0") unless amount_is_greater_than_zero?
  end

  def amount
    values[:amount].to_f
  end

  private
  def is_amount_nil?
    self.amount.nil?
  end

  def amount_is_greater_than_zero?
    self.amount.to_f > 0.0
  end
end