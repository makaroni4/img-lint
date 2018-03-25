# frozen_string_literal: true

# This is a module to keep constants like a path to the gem's directory
# to easily reference a default config file.
#
module IMGLint
  IMG_LINT_HOME = File.realpath(File.join(__dir__, "..", ".."))
end
