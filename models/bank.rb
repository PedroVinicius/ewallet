class Bank < Sequel::Model(:banks)
  one_to_many :accounts
end