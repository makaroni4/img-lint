# frozen_string_literal: true

require "yaml"
require "img_lint/constants"

module IMGLint
  # Config class is responsible to load img-lint either a user defined config
  # or a default one (config/default.yml)
  #
  class Config
    FILE_NAME = ".img-lint.yml".freeze
    DEFAULT_FILE = File.join(IMG_LINT_HOME, "config", "default.yml")

    class << self
      # Be default gem will try to load config file in user's project folder.
      # Then user's config (or empty object) will be merge with the default config
      # from gem's folder.
      #
      def load
        user_config = File.exist?(user_file) ? YAML.safe_load(File.read(user_file)) : {}
        default_config = YAML.safe_load(File.read(DEFAULT_FILE))

        default_config.merge(user_config)
      end

      private

      def user_file
        File.join(Dir.pwd, FILE_NAME)
      end
    end
  end
end
