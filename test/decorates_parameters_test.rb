require 'test_helper'

class DecoratesParametersTest < ActiveSupport::TestCase

  def params
    ActionController::DecoratesParameters.new(
      ActionController::Parameters.new(
        {
          :book => { :pages => 65 },
          :fishing => 'Turnips'
        }
      )
    )
  end

  test 'is_a? masquerades as a Hash or HashWithIndifferentAccess' do
    assert(params.is_a?(HashWithIndifferentAccess), 'not is_a? HashWithIndifferentAccess')
    assert(params.is_a?(Hash), 'not is_a? Hash')
  end

  test 'kind_of? masquerades as a Hash or HashWithIndifferentAccess' do
    assert(params.kind_of?(HashWithIndifferentAccess), 'not kind_of? HashWithIndifferentAccess')
    assert(params.kind_of?(Hash), 'not kind_of? Hash')
  end

  test 'require returns a string or another Decorates parameters object' do
    assert_equal(params.require(:book).class, ActionController::DecoratesParameters)
    assert_equal(params.require(:fishing).class, String)
  end
end
