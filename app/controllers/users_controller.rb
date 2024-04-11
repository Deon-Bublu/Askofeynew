class UsersController < ApplicationController
  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(
      :name, :nickname, :email, :password, :password_confirmation
    )

    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Aккаунт успешно создан!'
    else
      flash.now[:alert] = 'Неправильно заполнены поля регистрации'

      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_path, notice: 'Ваши данные обновлены'
    else
      flash.now[:alert] = 'При попытке сохранения возникла ошибка'

      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Аккаунт удалён'
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :nickname, :email, :password, :password_confirmation
    )
  end
end
