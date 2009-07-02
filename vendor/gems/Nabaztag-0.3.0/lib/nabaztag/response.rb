require 'rexml/document'

class Nabaztag
  class Response
    include REXML
    
    ERROR_MESSAGES = %w[
      NOGOODTOKENORSERIAL
      NOTAVAILABLE
    ]
    SUCCESS_MESSAGES = %w[
      TTSEND
      EARPOSITIONSEND
      POSITIONEAR
      MESSAGESEND
    ]
    # As at 2007-03-07, choreography and nabcast always return NOTAVAILABLE

    attr_reader :raw
    
    def initialize(xml)
      @raw = xml
      @doc = Document.new(xml)
    end
    
    def messages
      lookup('/rsp/message')
    end
    
    def comments
      lookup('/rsp/comment')
    end
    
    def left_ear
      position = lookup('/rsp/leftposition').first
      position && position.to_i
    end

    def right_ear
      position = lookup('/rsp/rightposition').first
      position && position.to_i
    end
    
    def success?
      (messages & ERROR_MESSAGES).empty?
    end
    
  private
  
    def lookup(xpath)
      XPath.match(@doc, xpath).map{ |n| n.text }
    end
    
  end
end