def content_for(name)
  response.template.instance_variable_get("@content_for_#{name}")
end