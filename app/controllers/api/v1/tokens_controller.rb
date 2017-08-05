class Api::V1::TokensController < Api::V1::ApplicationController

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      if user.activated?
        user.create_api_token
        @current_user = user
        render status: :created
      else
        render(
          plain: 'アカウントが有効化されていません。メールを確認してください',
          status: :unauthorized
        )
      end
    else
      render(
        plain: '無効なメールアドレスとパスワードの組み合わせです',
        status: :unauthorized
      )
    end
  end
end
