class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { message: 'Sorry, we can not found the record you are looking for.'}, status: :not_found
  end
end