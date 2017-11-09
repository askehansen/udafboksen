require 'mime-types'

class TelegramChat

  def initialize(user)
    @user = user
  end

  def send_document(file)
    type = MIME::Types.type_for(file.path).first
    bot.api.send_document(chat_id: @user.telegram_user_id, document: Faraday::UploadIO.new(file.path, type))
  end

  def send_message(text)
    bot.api.send_message(chat_id: @user.telegram_user_id, text: text)
  end

  private

  def bot
    @_bot ||= Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_TOKEN'])
  end

end
