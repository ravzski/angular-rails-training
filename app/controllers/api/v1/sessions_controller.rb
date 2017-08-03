class Api::V1::SessionsController < ApiController

  skip_before_action :authenticate_request, only: :create

  def show
    if current_user.present?
      render json: Sessions::Builder.new(current_user).show
    else
      fail ExpiredSessionError
    end
  end

  def create
    @user = User.not_deleted.find_by_credentials(params[:credentials])
    if @user.present? && @user.set_access_token
      render json: {access_token: @user.current_token}
    else
      fail InvalidCredentialsError
    end
  end

  def destroy
    if current_user.destroy_token
      render_success
    else
      fail InvalidRequestError
    end
  end

end
