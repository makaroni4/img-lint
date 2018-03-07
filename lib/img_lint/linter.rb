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

      images.select do |file|
        File.new(file).size > config["max_file_size"] * 1024
      end
    end

    def print_report(path, fat_images, verbose)
      if !fat_images.empty? && verbose
        puts "Suspicious images:"

        fat_images.each do |image|
          file_size = File.new(image).size / 1024

          image.sub!(Dir.pwd, "") if Dir.pwd == path

          puts [image, "#{file_size}Kb"].join("\t")
        end
      end
    end
  end
end
