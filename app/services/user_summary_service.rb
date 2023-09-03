class UserSummaryService

  def initialize(user, params = {})
    @user = user
    @params = params
    set_dates
  end

  def call
    events = @user.events.where(date: @date_from..@date_to).order(:date)

    beginning_of_period_balance = calculate_balance(events, @date_from)
    end_of_period_balance = calculate_balance(events, @date_to)

    {
      beginning_of_period: beginning_of_period_balance,
      end_of_period: end_of_period_balance,
      events: events
    }
  end

  private

  def calculate_balance(events, date)
    events_until_date = events.where('date <= ?', date)
    balance = @user.balance

    events_until_date.each do |event|
      if event.kind == 'income'
        balance += event.amount
      elsif event.kind == 'consumption'
        balance -= event.amount
      end
    end

    balance
  end

  def set_dates
    @date_from = @params['date_from'].nil? ? Date.current - 1.day : @params['date_from'].to_date
    @date_to = @params['date_to'].nil? ? Date.current : @params['date_to'].to_date
  end

end
