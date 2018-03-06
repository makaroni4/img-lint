module IMGLint
  class Linter
    attr_accessor :config

    def initialize(config: {})
      self.config = IMGLint::Config.load.merge(config)
    end

    def lint(path: Dir.pwd, verbose: true)
      max_file_size = config["max_file_size"].to_i

      big_images = Dir.glob(%(#{path}/**/*.{#{config["image_formats"]}})).select do |file|
        File.new(file).size > max_file_size * 1024
      end

      if big_images.size > 0 && verbose
        puts "Suspicious images:"

        big_images.each do |image|
          file_size = File.new(image).size / 1024

          puts [image, "#{file_size}Kb"].join("\t")
        end
      end

      big_images
    end
  end
end
