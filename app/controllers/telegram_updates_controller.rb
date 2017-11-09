class TelegramUpdatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    case params[:message][:text]
    when '/start'
      TelegramChat.new(current_user).send_message("Hej #{params[:message][:from][:first_name]}, hvad for en email har du brugt til at tilmelde dig?")
    when '/stop'
      current_user.update telegram_user_id: nil
    when '/latest'
      TelegramChat.new(current_user).send_document(current_user.messages.order(:created_at).last.eboks_message.file)
    when /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      if user = User.find_by(email: params[:message][:text])
        user.update telegram_user_id: params[:message][:from][:id]
        TelegramChat.new(user).send_message('Fantastisk! Du får nu dine e-Boks beskeder her i stedet for email')
      else
        TelegramChat.new(current_user).send_message('Jeg kunne ikke finde en bruger med den email')
      end
    end
  end

  private

  def current_user
    User.find_or_initialize_by(telegram_user_id: params[:message][:from][:id])
  end

end
