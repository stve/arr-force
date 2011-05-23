require 'faraday'

module Faraday
  class Response::ArrForce < Response::Middleware

    def parse(body)
      return body unless @to_array.any?

      case body
      when Hash
        normalize(body)
      when Array
        body.map { |item| item.is_a?(Hash) ? normalize(item) : item }
      else
        body
      end
    end

    def initialize(env = nil, *args)
      @to_array = [args.shift].flatten.map { |k| k.to_s }
      super(env)
    end

    private

    def normalize(response_object)
      if response_object.kind_of?(Hash)
        response_object.each_pair do |key, value|
          if @to_array.include?(key.to_s)
            response_object[key] = [normalize(value)].flatten
          else
            response_object[key] = normalize(value)
          end
        end
      else
        response_object
      end
      response_object
    end
  end
end
