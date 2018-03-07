module IMGLint
  class Linter
    attr_accessor :config

    def initialize(config: {})
      self.config = IMGLint::Config.load.merge(config)
    end

    def lint(path: Dir.pwd, verbose: true)
      path ||= Dir.pwd

      max_file_size = config["max_file_size"].to_i

      images = Dir.glob(%(#{path}/**/*.{#{config["image_formats"]}}))

      puts "No images found in #{path}" if images.empty?

      fat_images = images.select do |file|
        File.new(file).size > max_file_size * 1024
      end

      if fat_images.size > 0 && verbose
        puts "Suspicious images:"

        fat_images.each do |image|
          file_size = File.new(image).size / 1024

          puts [image, "#{file_size}Kb"].join("\t")
        end
      end

      fat_images
    end
  end
end
