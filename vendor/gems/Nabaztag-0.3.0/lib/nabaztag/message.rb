require 'cgi'
require 'iconv'
require 'open-uri'
require 'nabaztag/response'

class Nabaztag
  class Message

    SERVICE_ENCODING = 'iso-8859-1'
    API_URI = 'http://api.nabaztag.com/vl/FR/api.jsp?'
    FIELDS = [
      :idmessage, :posright, :posleft, :idapp, :tts, :chor, :chortitle, :ears, :nabcast, 
      :ttlive, :voice, :speed, :pitch
    ]

    FIELDS.each do |field|
      attr_accessor field
    end

    def initialize(mac, token)
      @mac, @token = mac, token
      @expected_identifiers = []
    end
    
    def send
      Response.new(open(request_uri){ |io| io.read })
    end
    
    def expect(identifier)
      @expected_identifiers << identifier
    end

  private

    def request_uri
      API_URI + parameters.sort_by{ |k,v| k.to_s }.map{ |k,v|
        value = CGI.escape(encode_text(v.to_s))
        "#{k}=#{value}"
      }.join('&')
    end
    
    def parameters
      FIELDS.inject({
        :sn => @mac,
        :token => @token
      }){ |hash, element|
        value = __send__(element)
        hash[element] = value if value
        hash
      }
    end

    def encode_text(string)
      Iconv.iconv(SERVICE_ENCODING, 'utf-8', string)[0]
    end

  end
end
