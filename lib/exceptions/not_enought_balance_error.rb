class NotEnoughtBalanceError < StandardError
  def initialize(message = 'Your balance is not enought to complete this transaction.')
    super(message)
  end
end