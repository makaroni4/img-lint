# frozen_string_literal: true

module IMGLint
  # Linter class is responsible for checking images (only formats specified
  # in config) if they exceed a curtain size. It also prints out list of
  # suspicious images.
  #
  class Linter
    # Be default gem will merge user-defined condif with the default one.
    #
    def initialize(config: {})
      @config = IMGLint::Config.load.merge(config)
    end

    # The gem's core method which actually goes through all images files and
    # checks whether the image size exceeds the max size from config.
    #
    # Verbose attribute is there to surpress output when running specs.
    #
    def lint(path: Dir.pwd, verbose: true)
      path ||= Dir.pwd

      heavy_images = find_heavy_images(path, verbose)

      print_report(path, heavy_images, verbose)

      heavy_images
    end

    private

    def find_heavy_images(path, verbose)
      images = Dir.glob(%(#{path}/**/*.{#{@config['image_formats']}}))

      puts "--> img-lint found no images in #{path}" if verbose && images.empty?

      images.each_with_object({}) do |file, o|
        next if excluded_file?(file)

        image_size = File.new(file).size / 1024

        o[file] = image_size if image_size > @config["max_file_size"]
      end
    end

    def exclude_patterns
      @exclude_patterns ||= @config.fetch("exclude", []).map! do |pattern|
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

    def longest_path_and_file_size(path, heavy_images)
      longest_image_path = heavy_images.keys.max { |k| k.size }
      longest_image_path = longest_image_path.sub(Dir.pwd, "") if Dir.pwd == path

      longest_file_size = heavy_images.values.max { |v| v.to_s.size }.size

      [longest_image_path.size, longest_file_size]
    end

    def print_report(path, heavy_images, verbose)
      return unless verbose

      if heavy_images.empty?
        puts "--> img-lint detected no heavy images"
        return
      end

      puts "--> img-lint detected heavy images:"

      longest_image_path_size, longest_file_size = longest_path_and_file_size(path, heavy_images)

      heavy_images.sort_by(&:last).reverse.each do |image, file_size|
        image = image.sub(Dir.pwd, "") if Dir.pwd == path

        puts [image.ljust(longest_image_path_size), "#{file_size}Kb".rjust(longest_file_size)].join("\t")
      end
    end
  end
end
