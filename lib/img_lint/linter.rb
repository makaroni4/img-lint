# frozen_string_literal: true

module IMGLint
  # Linter class is responsible for checking images (only formats specified
  # in config) if they exceed a curtain size. It also prints out list of
  # suspicious images.
  class Linter
    attr_accessor :config

    def initialize(config: {})
      self.config = IMGLint::Config.load.merge(config)
    end

    def lint(path: Dir.pwd, verbose: true)
      path ||= Dir.pwd

      fat_images = find_fat_images(path, verbose)

      print_report(path, fat_images, verbose)

      fat_images
    end

    private

    def find_fat_images(path, verbose)
      images = Dir.glob(%(#{path}/**/*.{#{config['image_formats']}}))

      puts "No images found in #{path}" if verbose && images.empty?

      images.each_with_object({}) do |file, o|
        image_size = File.new(file).size / 1024

        if !excluded_file?(file) && image_size > config["max_file_size"]
          o[file] = image_size
        end
      end
    end

    def exclude_patterns
      @exclude_patterns ||= config.fetch("exclude", []).map! do |pattern|
        if pattern.start_with?("/")
          pattern
        else
          File.expand_path(pattern, File.expand_path(Dir.pwd))
        end
      end
    end

    def excluded_file?(file_path)
      exclude_patterns.any? do |pattern|
        File.fnmatch?(pattern, file_path)
      end
    end

    def print_report(path, fat_images, verbose)
      return if fat_images.empty? || !verbose

      puts "Suspicious images:"

      longest_image_path = fat_images.keys.max { |k| k.size }.size
      longest_file_size = fat_images.values.max { |v| v.to_s.size }.size

      fat_images.sort_by(&:last).reverse.each do |image, file_size|
        image = image.sub(Dir.pwd, "") if Dir.pwd == path

        puts [image.ljust(longest_image_path), "#{file_size}Kb".rjust(longest_file_size)].join("\t")
      end
    end
  end
end
