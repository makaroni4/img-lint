require "filesize"

module IMGLint
  class Linter
    def lint(config)
      max_file_size = Filesize.from(config["max_file_size"]).to_i

      big_images = Dir.glob(%(#{Dir.pwd}/**/*.{#{config["image_formats"]}})).select do |file|
        File.size(file) > max_file_size
      end

      if big_images.size > 0
        puts "Suspicious images:"

        big_images.each do |image|
          filesize = Filesize.new("#{File.size(image)} B", Filesize::SI)

          puts [image, filesize.pretty].join("\t")
        end
      end
    end
  end
end
