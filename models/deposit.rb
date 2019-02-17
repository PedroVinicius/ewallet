class Deposit < Sequel::Model(:deposits)
  many_to_one :account

  def amount
    values[:amount].to_f
  end
end