module TwilioMatchers
  class EmptyTwilioSmsResponse

    EXPECTED = <<-expectation
<?xml version="1.0" encoding="UTF-8" ?>
<Response>
</Response>
    expectation

    def matches?(target)
      @target = target
      @target.eql?(EXPECTED)
    end

    def failure_message
      "expected: #{EXPECTED}\nbut got: #{@target.inspect}"
    end

    def negative_failure_message
      "got response: #{@target.inspect}\nbut did not expect it"
    end
  end

  class FilledTwilioSmsResponse

    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @target = target
      @target.should =~ Regexp.new(Regexp.escape("<Sms>#{@expected}</Sms>"))
    end

    def failure_message
      "expected to contain: #{@expected}\nbut did not: #{@target.inspect}"
    end

    def negative_failure_message
      "got response: #{@target.inspect}\n but did not expect it"
    end
  end

  def have_empty_twilio_response
    EmptyTwilioSmsResponse.new
  end

  def have_twilio_message(message)
    FilledTwilioSmsResponse.new(message)
  end
end