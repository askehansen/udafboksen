class MessageMailer < ApplicationMailer

  def new_message(message)
    @message = message
    @user = message.user
    @eboks_message = message.eboks_message
    @filename = "#{@eboks_message.name.split(' ').first}.#{@eboks_message.format}"

    attachments[@filename] = @eboks_message.content

    mail to: @user.email, subject: @eboks_message.name, from: "#{@eboks_message.sender} <service@udafboksen.herokuapp.com>"
  end

end
