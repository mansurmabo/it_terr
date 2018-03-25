module Response
  def json_response(object, status = 200)
    render json: object, status: status
  end

  def fail_response(message, status = 422)
    render json: {errors: message}, status: status
  end

end
