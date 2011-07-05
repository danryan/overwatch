module ApplicationHelper
  def remove_rule(rule)
    html_options = {}
    html_options[:class] = 'remove_fields'
    rule.hidden_field(:_destroy) + link_to("remove", "#", html_options)
  end
  
  def add_rule(f)
    new_object = Check.new
    fields = f.simple_fields_for(:rules, new_object, :child_index => "new_check") do |builder|
      render("rule_fields", :f => f)
    end
    html_options = {}
    html_options[:class] = 'add_fields'
    link_to 'add rule', '#'
  end
  
  def time_in_ms
    (Time.now - 1.hour).to_i * 1000
  end
end
