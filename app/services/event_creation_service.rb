class EventCreationService

  def initialize(params)
    @user = User.find(params['user_id'])
    @kind = params['kind']
    @name = params['name']
    @amount = params['amount'].to_f
  end

  def call
    return 'invalid amount' unless @amount.positive?
    return 'invalid name' if @name.nil?

    if @kind == 'income'
      income_transaction
    elsif @kind == 'consumption'
      consumption_transaction
    else
      "Invalid kind: #{@kind}"
    end
  end

  private

  def can_buy?
    @user.with_lock do
      @user.balance >= @amount
    end
  end

  def income_transaction
    ActiveRecord::Base.transaction do
      Event.create!(amount: @amount, date: Date.current, kind: @kind, name: @name, user_id: @user.id)
      @user.increment!(:balance, @amount)
    end
  end

  def consumption_transaction
    return 'There are not enough funds in your account' unless can_buy?

    ActiveRecord::Base.transaction do
      Event.create!(amount: @amount, date: Date.current, kind: @kind, name: @name, user_id: @user.id)
      @user.decrement!(:balance, @amount)
    end
  end

end
