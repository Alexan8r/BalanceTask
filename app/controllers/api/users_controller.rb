class Api::UsersController < Api::BaseController

  before_action :set_user, except: :index

  def index
    render json: User.all
  end

  def show
    render json: {
      user: @user,
      events: @user.events.sort_by(&:date)
    }
  end

  def summary
    events = UserSummaryService.new(@user, params).call

    render json: events
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
