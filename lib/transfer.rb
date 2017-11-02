class Transfer

  attr_reader :sender, :receiver
  attr_accessor :status, :amount
  # @@id = 0

  def initialize(sender, receiver, amount = 50)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
    @id = 0
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if !@sender.valid? || @sender.balance < @amount
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    elsif @id == 0
      @sender.balance -= @amount
      @receiver.deposit(@amount)
      @id += 1
      @status = 'complete'
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @receiver.balance -= @amount
      @sender.deposit(@amount)
      @status = 'reversed'
    end
  end

end
