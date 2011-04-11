module Overwatch
  module Helpers
    def format_errors(model)
      error_messages = model.errors.present do |e|
        # Missing attributes
        e.on [:name, :not_present], "Name attribute missing"
        e.on [:data, :not_present], "Data attribute missing"
        # Uniqueness
        e.on [:name, :not_unique], "Name already taken"
      end
      error_messages.first
    end
  end
end