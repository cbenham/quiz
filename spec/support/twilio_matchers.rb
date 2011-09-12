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
      "got response: #{@target}\nbut did not expect it"
    end
  end

  def have_empty_response
    EmptyTwilioSmsResponse.new
  end
end