module IMGLint
  class Linter
    def lint(config)
      max_file_size = config["max_file_size"].to_i

      big_images = Dir.glob(%(#{Dir.pwd}/**/*.{#{config["image_formats"]}})).select do |file|
        File.new(file).size > max_file_size
      end

      if big_images.size > 0
        puts "Suspicious images:"

        big_images.each do |image|
          file_size = File.new(image).size / 1024

          puts [image, file_size].join("\t")
        end
      end
    end
  end
end
