class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new params[:user].permit!

    if Eboks::Session.new(@user).authenticated?
      @user.save!
      redirect_to @user
    else
      render json: { error: 'Kunne ikke logge ind på din e-Boks med de indtastede oplysninger' }, status: :unprocessable_entity
    end
  end

end
