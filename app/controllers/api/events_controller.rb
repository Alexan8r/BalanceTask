class Api::EventsController < Api::BaseController

  def create
    if params[:event].blank?
      render json: 'blank_params', status: :not_found
    elsif User.find_by(id: params.dig('event', 'user_id')).nil?
      render json: 'User not found', status: :not_found
    else
      result = EventCreationWorker.new(params[:event]).perform
      render json: result
    end
  end

end
