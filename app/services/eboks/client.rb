class Eboks::Client

  BASE_URL = 'https://rest.e-boks.dk/mobile/1/xml.svc/en-gb'.freeze

  def initialize(auth)
    @auth = auth
  end

  def put(path, body)
    authenticated.put("#{BASE_URL}/#{path}", body: body)
  end

  def get(path)
    authenticated.get("#{BASE_URL}/#{path}")
  end

  def authenticated
    HTTP.headers('Content-Type' => 'application/xml', 'X-EBOKS-AUTHENTICATE' => @auth)
  end


end
