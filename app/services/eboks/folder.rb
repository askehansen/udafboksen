class Eboks::Folder
  attr_accessor :id, :name, :unread, :session

  def self.all(session)
    response = Oga.parse_xml(session.get('0/mail/folders').to_s)

    response.css('FolderInfo').map do |element|
      self.build(element, session)
    end
  end

  def self.build(element, session)
    self.new.tap do |folder|
      folder.id = element.get('id')
      folder.name = element.get('name')
      folder.unread = element.get('unread')
      folder.session = session
    end
  end

  def messages
    Eboks::Message.all(session, folder: self)
  end

end
