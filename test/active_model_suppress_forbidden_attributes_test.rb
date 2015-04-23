require 'test_helper'

class Person
  include ActiveModel::MassAssignmentSecurity
  include ActiveModel::SuppressForbiddenAttributes

  public :sanitize_for_mass_assignment
end

class ActiveModelSuppressForbiddenAttributesTest < ActiveSupport::TestCase
  def setup
    @log = StringIO.new
    ParamsPatrol.handler= lambda { |x| Logger.new(@log).info(x) }
  end

  test 'forbidden attributes are logged' do
    Person.new.sanitize_for_mass_assignment(ActionController::Parameters.new(a: 'b'))
    @log.rewind
    assert_block do
      /ActiveModel::ForbiddenAttributes/.match(@log.read)
    end
  end

  test 'no error is thrown' do
    assert_nothing_thrown do
      Person.new.sanitize_for_mass_assignment(ActionController::Parameters.new(a: 'b'))
    end
  end
end
