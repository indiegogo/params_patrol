require "active_model/suppress_forbidden_attributes"
require "action_controller/handle_unpermitted_parameters"
require "params_patrol/version"

module ParamsPatrol
  def self.handler
    @handler
  end

  def self.handler=(handler)
    @handler = handler
  end

  def self.handle(*options)
    if @handler.nil?
      @handler = lambda { |x| Logger.new(STDOUT).info(x) }
    end
    @handler.call(options)
  end
end
