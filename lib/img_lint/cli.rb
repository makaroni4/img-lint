# frozen_string_literal: true

require "img_lint/config"
require "img_lint/linter"
require "optparse"

$LOAD_PATH << File.expand_path(__dir__)

module IMGLint
  # CLI class
  #
  class CLI
    def run(args = [])
      if args.first == "install"
        require "fileutils"

        target_file = File.join(Dir.pwd, ".img-lint.yml")
        config_file = File.join(File.expand_path(__dir__), "..", "config", "default.yml")

        FileUtils.cp(config_file, target_file)

        0
      else
        options = extract_options(args)

        config = IMGLint::Config.load
        config.merge!(options)

        path = config.delete("path")

        linter = IMGLint::Linter.new(config: config)
        fat_images = linter.lint(path: path)

        fat_images.empty? ? 0 : 2
      end
    end

    private

    def unindent(str)
      str.gsub(/^#{str.scan(/^[ \t]+(?=\S)/).min}/, "")
    end

    def extract_options(args)
      options = {}

      OptionParser.new do |opts|
        opts.banner = unindent(<<-TEXT)
          img-lint help

          1. img-lint install

          This will copy default config to your local .img-lint.yml file

          2. img-lint [options]
        TEXT

        opts.on("-v", "--version", "Prints current version of img-lint") do
          puts IMGLint::VERSION
          exit 0
        end

        opts.on("-p", "--path PATH", "Path to a folder with images") do |v|
          options["path"] = v
        end

        opts.on("-m", "--max-size MAX_SIZE", "Max image size allowed, '150' by default (150Kb)") do |v|
          options["max_file_size"] = v.to_i
        end

        opts.on("-f", "--format IMAGE_FORMATS", "Image formats, 'jpg,png,gif' by default") do |v|
          options["image_formats"] = v
        end
      end.parse!(args)

      options
    end
  end
end
