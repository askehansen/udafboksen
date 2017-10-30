namespace :messages do
  desc "Syncs new messages from eboks"
  task sync: :environment do
    User.find_each do |user|
      session = Eboks::Session.new(user)
      folder = Eboks::Folder.all(session).first
      folder.messages.each do |eboks_message|
        message = Message.find_or_initialize_by(eboks_id: eboks_message.id)
        if message.new_record?
          message.eboks_folder_id = folder.id
          message.user = user
          message.status = :unprocessed
          message.save

        end
      end
    end
  end

  desc "Sends unprocessed messages to user"
  task process: :environment do
    Message.unprocessed.find_each do |message|
      MessageMailer.new_message(message).deliver_later
      message.processed!
    end
  end

end
