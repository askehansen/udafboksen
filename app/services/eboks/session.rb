class Eboks::Session

  def initialize(user)
    @user = user
    @deviceid = SecureRandom.uuid
  end

  def get(path)
    Eboks::Client.new(authenticated_hash).get("#{@userid}/#{path}")
  end

  private

  def authenticate!
    response = Eboks::Client.new(authentication_hash).put('session', to_xml)
    auth_data = response.headers["X-Eboks-Authenticate"].gsub(/"/, '').split(',')
    auth_data = auth_data.map { |x| x.strip.split('=') }.to_h
    @sessionid = auth_data['sessionid']
    @nonce = auth_data['nonce']
    body = Oga.parse_xml(response.to_s)
    @userid = body.at_css('User').get('userId')
  end

  def authenticated_hash
    authenticate!
    response = [activation, @deviceid, @nonce, @sessionid].join(':')
    response = Digest::SHA256.hexdigest(Digest::SHA256.hexdigest(response))
    "deviceid=#{@deviceid},nonce=#{@nonce},sessionid=#{@sessionid},response=#{response}"
  end

  def activation
    @user.eboks_activation_key
  end

  def authentication_hash
    datetime = DateTime.now.strftime('%Y-%m-%d %H:%M:%S%Z')
    type = 'P'
    cpr = @user.ssid
    country = 'DK'
    password = @user.eboks_password

    challenge = [activation, @deviceid, type, cpr, country, password, datetime].join(':')
    challenge = Digest::SHA256.hexdigest(Digest::SHA256.hexdigest(challenge))

    "logon deviceid=#{@deviceid},datetime=#{datetime},challenge=#{challenge}"
  end

  def to_xml
    "<Logon xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns='urn:eboks:mobile:1.0.0'>
    	<App version='1.4.1' os='iOS' osVersion='9.0.0' Device='iPhone' />
    <User identity='#{@user.ssid}' identityType='P' nationality='DK' pincode='#{@user.eboks_password}'/>
    </Logon>"
  end

end
