class Api::EventsController < Api::BaseController

  def create
    render json: 'blank_params' if params[:event].blank?

    user = User.find_by(id: params.dig('event', 'user_id'))
    if user.nil?
      render json: 'User not found', status: :not_found
    else
      result = EventCreationWorker.new(params[:event]).perform
      render json: result
    end
  end

end
