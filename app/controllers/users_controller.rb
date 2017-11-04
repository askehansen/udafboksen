class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @latest_message = @user.messages.order(:created_at).first
    MessageMailer.new_message(@latest_message).deliver_now
  end

  def create
    @user = User.new params[:user].permit!

    if Eboks::Session.new(@user).authenticated?
      @user.save!
      sync_messages @user
      redirect_to @user
    else
      render json: { error: 'Kunne ikke logge ind på din e-Boks med de indtastede oplysninger' }, status: :unprocessable_entity
    end
  end

  private


  def sync_messages(user)
    session = Eboks::Session.new(user)
    folder = Eboks::Folder.all(session).first
    folder.messages.each do |eboks_message|
      message = Message.find_or_initialize_by(eboks_id: eboks_message.id, user: user)
      if message.new_record?
        message.eboks_folder_id = folder.id
        message.user = user
        message.status = :processed
        message.save
      end
    end
  end

end
