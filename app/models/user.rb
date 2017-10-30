class User < ApplicationRecord
  attr_encrypted :ssid, key: ENV['ENCRYPTION_KEY']
  attr_encrypted :eboks_password, key: ENV['ENCRYPTION_KEY']
  attr_encrypted :eboks_activation_key, key: ENV['ENCRYPTION_KEY']

  has_many :messages

  def eboks_session
    Eboks::Session.new(self)
  end

end
