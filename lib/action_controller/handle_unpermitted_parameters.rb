module ActionController
  class DecoratesParameters
    attr_reader :params

    methods_to_delegate = (ActionController::Parameters.new.methods - Object.new.methods - [:permit, :[]]) + [:to_s, :is_a?, :kind_of?]
    delegate *methods_to_delegate, :to => :params

    def initialize(params)
      @params = params
    end

    def [](key)
      result = params[key]
      result.is_a?(Hash) ? DecoratesParameters.new(result) : result
    end

    def require(key)
      result = params[key].presence || raise(ActionController::ParameterMissing.new(key))
      result.is_a?(Hash) ? DecoratesParameters.new(result) : result
    end

    def permit(*filters)
      params.permit(*filters)
    rescue => e
      ParamsPatrol.handle(error: e, parameters: params, cgi_data: ENV.to_hash)
      self
    end
  end

  module HandleUnpermittedParameters
    def params
      @_params ||= DecoratesParameters.new(Parameters.new(request.parameters))
    end

    def params=(val)
      @_params = val.is_a?(Hash) ? DecoratesParameters.new(Parameters.new(val)) : val
    end
  end
end
