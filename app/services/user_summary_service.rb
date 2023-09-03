class UserSummaryService
  def initialize(user, params = {})
    @user = user
    @params = params

    set_dependencies
  end

  def call
    {
      beginning_of_period: from_period_balance,
      end_of_period: to_period_balance,
      balance: @user.balance,
      events: @user.events.where(date: @date_from..@date_to).order(:date)
    }
  end

  private

  def from_period_balance
    start_balance + @inc_events.where('date < ?',
                                      @date_from).sum(&:amount) - @cons_events.where('date < ?', @date_from).sum(&:amount)
  end

  def to_period_balance
    dates = @date_from..@date_to
    from_period_balance + @inc_events.where(date: dates).sum(&:amount) - @cons_events.where(date: dates).sum(&:amount)
  end

  def start_balance
    @user.balance - @inc_events.sum(&:amount) + @cons_events.sum(&:amount)
  end

  def set_dependencies
    @date_from = @params['date_from'].nil? ? Date.current - 1.day : @params['date_from'].to_date
    @date_to = @params['date_to'].nil? ? Date.current : @params['date_to'].to_date
    events = @user.events
    @cons_events = events.consumption
    @inc_events = events.income
  end
end
