# frozen_string_literal: true

require "rake"
require "rake/tasklib"
require "img_lint/cli"

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

        exit IMGLint::CLI.new.run
      end
    end
  end
end
