class Transference < Sequel::Model(:transferences)
  many_to_one :transferor, class: :Account, key: :source_account_id
  many_to_one :transferee, class: :Account, key: :destination_account_id

  def amount
    values[:amount].to_f
  end
end