module ActiveModel
  module SuppressForbiddenAttributes
    def sanitize_for_mass_assignment(*options)
      new_attributes = options.first
      if new_attributes.respond_to?(:permitted?) && !new_attributes.permitted?
        ParamsPatrol.handle(error: ActiveModel::ForbiddenAttributes.new,
                            parameters: options.try(:first),
                            cgi_data: ENV.to_hash)
        # help surface these kinds of issues in the test env
        # raise(ActiveModel::ForbiddenAttributes) if Rails.env.test?
      end

      ActiveModel::MassAssignmentSecurity.instance_method(:sanitize_for_mass_assignment).bind(self).call(*options)
    end
  end
end
