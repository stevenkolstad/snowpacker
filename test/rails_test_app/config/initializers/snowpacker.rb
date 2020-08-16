Rails.application.config.middleware.insert_before 0, Snowpacker::Proxy, {ssl_verify_none: true}

Snowpacker.configure do |snowpacker|
  # Where to find the config directory
  snowpacker.config_dir = Rails.root.join("config", "snowpacker")

  # Where to find the snowpack config file
  snowpacker.config_file = File.join(snowpacker.config_dir, "snowpack.config.js")

  # Where to find the babel config file
  snowpacker.babel_config_file = File.join(snowpacker.config_dir, "babel.config.js")

  # Where to find the postcss config file
  snowpacker.postcss_config_file = File.join(snowpacker.config_dir, "postcss.config.js")

  # Where to find your snowpack files
  snowpacker.mount_dir = File.join("app", "snowpacker")

  # Where to build snowpack to (out dir)
  snowpacker.build_dir = "public"

  # Appends to build_dir
  snowpacker.output_path = "snowpacks" # => /build_dir/snowpacks

  # What port to run snowpacker with
  snowpacker.port = "4035"

  # What hostname to use
  snowpacker.hostname = "localhost"

  # To add additional attributes you can do the following:
  # snowpacker.add_attr("attr_name", "attr_value")
end

ActiveSupport.on_load :action_controller do
  ActionController::Base.helper Webpacker::Helper
end

ActiveSupport.on_load :action_view do
  include Webpacker::Helper
end