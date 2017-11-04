class Eboks::Message
  attr_accessor :id, :name, :sender, :received_at, :session, :folder, :format

  def self.all(session, folder:)
    response = Oga.parse_xml(session.get("0/mail/folder/#{folder.id}?skip=0&take=1000").to_s)

    response.css('MessageInfo').map do |element|
      self.build(element, session, folder)
    end
  end

  def self.build(element, session, folder)
    self.new.tap do |message|
      message.id = element.get('id')
      message.name = element.get('name')
      message.received_at = DateTime.parse(element.get('receivedDateTime'))
      message.format = element.get('format').downcase
      message.sender = element.at_css('Sender').text
      message.session = session
      message.folder = folder
    end
  end

  def self.find(session, id, folder: folder)
    response = Oga.parse_xml(session.get("0/mail/folder/#{folder.id}/message/#{id}").to_s)

    self.build(response.at_css('Message'), session, folder)
  end

  def content
    session.get("0/mail/folder/#{folder.id}/message/#{@id}/content").to_s
  end

end
