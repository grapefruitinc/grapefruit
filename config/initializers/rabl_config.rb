Rabl.configure do |config|
  config.include_json_root = false

  # Allows rendering partials
  config.view_paths = [Rails.root.join('app', 'views', 'api', 'v1')]
end