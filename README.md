[![Gem Version](https://badge.fury.io/rb/img-lint.svg)](https://badge.fury.io/rb/img-lint)
[![Build Status](https://travis-ci.org/makaroni4/img-lint.svg?branch=master)](https://travis-ci.org/makaroni4/img-lint)
[![Maintainability](https://api.codeclimate.com/v1/badges/5bae5351eeac876e2192/maintainability)](https://codeclimate.com/github/makaroni4/img-lint/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/makaroni4/img-lint/badge.svg)](https://coveralls.io/github/makaroni4/img-lint)
[![Inline docs](http://inch-ci.org/github/makaroni4/img-lint.svg?branch=master)](http://inch-ci.org/github/makaroni4/img-lint)

<p align="center">
  <img src="https://user-images.githubusercontent.com/768070/37737892-76a69720-2d55-11e8-88e3-dfe3c5b5ae08.png" width="50%" alt="img-lint logo">
</p>

`img-lint` will help to keep your webapp from serving heavy and not optimized images. It's a zero-dependencies Ruby gem that will scan specified folders for images with size above a certain threshold. It could be run manually or easily integrated into CI.

## Installation

~~~bash
gem install img-lint
~~~

or add it to your `Gemfile` and run `bundle install`:

~~~ruby
gem 'img-lint', require: false
~~~

## Usage

Run `img-lint` in your console to lint images in the current folder or pass some arguments like so:

~~~bash
img-lint -p /path/to/project -f "jpg,png" -m 30
~~~

Command Line Flag         | Description
--------------------------|----------------------------------------------------
`-p`/`--path`             | Path to a folder with images
`-m`/`--max-size`         | Max image size allowed in Kb
`-f`/`--format`           | Image formats, 'jpg,png,gif' by default
`-h`/`--help`             | Show help

## Configuration

Run `img-lint install` from the command line to generate `.img-lint.yml` config file:

~~~yaml
max_file_size: 150 # Kb
image_formats: "jpg,png,gif"
exclude:
  - "tmp/**/**"
  - "vendor/**/**"
~~~

Configuration from `.img-lint.yml` will extend the [default configuration](config/default.yml).

## Rake integration

To execute scss-lint via a Rake task, add the following to your Rakefile:

~~~ruby
require "img_lint/rake_task"

IMGLint::RakeTask.new
~~~

Make sure to specify your [config](#configuration) when running img-lint with Rake or in CI mode.

## Contributing

That would be awesome to see you involved: Try out `img-lint`, give feedback via email or simply open an issue. If you're opening a PR, try to add some specs, so we keep the project stable:

~~~ruby
bundle exec rspec
~~~

By participating, you are expected to honor [Code of Conduct](https://github.com/makaroni4/img-lint/blob/master/CODE_OF_CONDUCT.md).

## License

This project is released under the [MIT License](https://github.com/makaroni4/img-lint/blob/master/LICENSE.txt).
