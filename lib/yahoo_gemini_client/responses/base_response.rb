module YahooGeminiClient
  class BaseResponse
    def error?
      !@errors.nil?
    end
  end
end
