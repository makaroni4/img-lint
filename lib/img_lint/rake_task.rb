# frozen_string_literal: true

require "rake"
require "rake/tasklib"

module IMGLint
  # Rake task
  #
  class RakeTask < Rake::TaskLib
    def initialize(name = :img_lint)
      @name = name

      define
    end

    private

    def define
      desc "img-lint"

      task(@name) do |_task|
        require "img_lint"

        linter = IMGLint::Linter.new
        fat_images = linter.lint

        exit fat_images.empty? ? 0 : 2
      end
    end
  end
end
