class Message < ApplicationRecord
  belongs_to :user

  enum status: {
    unprocessed: 0,
    processed: 1
  }

  def eboks_message
    @_eboks_message ||= begin
      folder = Eboks::Folder.new
      folder.id = eboks_folder_id
      Eboks::Message.find(user.eboks_session, eboks_id, folder: folder)
    end
  end


end
