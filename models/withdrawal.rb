class Withdrawal < Sequel::Model(:withdrawals)
  many_to_one :account

  def amount
    values[:amount].to_f
  end
end