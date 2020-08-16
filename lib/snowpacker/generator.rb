require "thor"
require "snowpacker/utils"

module Snowpacker
  class Generator < Thor::Group
    include Thor::Actions
    include Utils

    TEMPLATES = File.join(File.expand_path(__dir__), "templates")
    CONFIG_FILES = %w[
      snowpack.config.js
      postcss.config.js
      babel.config.js
    ]

    def self.source_root
      TEMPLATES
    end

    def create_initializer_file
      target = "snowpacker.rb"
      source = "#{target}.tt"

      destination = File.join("config", "initializers", target)

      if rails?
        destination = Rails.root.join("config", "initializers", target)
      end

      # Creates a config/initializers/snowpacker.rb file
      say "\n\nCreating initializer file at #{destination}...\n\n", :magenta
      template source, destination
    end

    def create_config_files
      destination = File.join("config", "snowpacker")

      if rails?
        destination = Rails.root.join("config", "snowpacker")
      end

      say "\n\nCreating config files @ #{destination}...\n\n", :magenta
      CONFIG_FILES.each do |filename|
        template filename, File.join(destination, filename)
      end
    end

    def add_yarn_packages
      say "\n\nAdding yarn packages...\n\n", :magenta
      Rake.sh %(yarn add -D #{::Snowpacker::YARN_PACKAGES.join(" ")})
    end

    def init
      create_initializer_file
      create_config_files
      add_yarn_packages

      say "Finished initializing snowpacker", :green
    end
  end
end
