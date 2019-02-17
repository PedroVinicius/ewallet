class Account < Sequel::Model(:accounts)
  many_to_one :user
  many_to_one :bank

  one_to_many :deposits
  one_to_many :withdrawals
  one_to_many :sent_transferences, class: :Transference, key: :source_account_id
  one_to_many :received_transferences, class: :Transference, key: :destination_account_id

  def balance
    deposits = self.deposits_dataset.sum(:amount) || 0
    withdrawals = self.withdrawals_dataset.sum(:amount) || 0

    sent_transferences_amount = sent_transferences_dataset.sum(:amount) || 0
    received_transferences_amount = received_transferences_dataset.sum(:amount) || 0

    ((deposits + received_transferences_amount) - (withdrawals + sent_transferences_amount))
  end
end