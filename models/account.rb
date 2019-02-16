class Account < Sequel::Model(:accounts)
  many_to_one :user
  many_to_one :bank
end