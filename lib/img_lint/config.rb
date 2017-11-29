require "yaml"

module IMGLint
  class Config
    FILE_NAME = ".img-lint.yml"
    DEFAULT_FILE = File.join(IMG_LINT_HOME, "config", "default.yml")

    class << self
      def load
        user_config = File.exist?(user_file) ? YAML.load(File.read(user_file)) : {}
        default_config = YAML.load(File.read(DEFAULT_FILE))

        default_config.merge(user_config)
      end

      private

      def user_file
        File.join(Dir.pwd, FILE_NAME)
      end
    end
  end
end
