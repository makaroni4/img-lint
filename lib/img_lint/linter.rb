module IMGLint
  class Linter
    attr_accessor :config

    def initialize(config: {})
      self.config = IMGLint::Config.load.merge(config)
    end

    def lint(path: Dir.pwd, verbose: true)
      path ||= Dir.pwd

      images = Dir.glob(%(#{path}/**/*.{#{config["image_formats"]}}))

      puts "No images found in #{path}" if verbose && images.empty?

      fat_images = images.select do |file|
        File.new(file).size > config["max_file_size"] * 1024
      end

      print_report(path, fat_images, verbose)

      fat_images
    end

    private

    def print_report(path, fat_images, verbose)
      if fat_images.size > 0 && verbose
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
