[![Gem Version](https://badge.fury.io/rb/img-lint.svg)](https://badge.fury.io/rb/img-lint)
[![Build Status](https://travis-ci.org/makaroni4/img-lint.svg?branch=master)](https://travis-ci.org/makaroni4/img-lint)
[![Maintainability](https://api.codeclimate.com/v1/badges/5bae5351eeac876e2192/maintainability)](https://codeclimate.com/github/makaroni4/img-lint/maintainability)
[![Dependency Status](https://gemnasium.com/badges/github.com/makaroni4/img-lint.svg)](https://gemnasium.com/github.com/makaroni4/img-lint)
[![Coverage Status](https://coveralls.io/repos/github/makaroni4/img-lint/badge.svg)](https://coveralls.io/github/makaroni4/img-lint)
[![Inline docs](http://inch-ci.org/github/makaroni4/img-lint.svg?branch=master)](http://inch-ci.org/github/makaroni4/img-lint)

<p align="center">
  <img src="https://user-images.githubusercontent.com/768070/37737892-76a69720-2d55-11e8-88e3-dfe3c5b5ae08.png" width="50%" alt="img-lint logo">
</p>

`img-lint` will help to keep your webapp from serving heavy and not optimized images. It's a zero-dependencies Ruby gem that will scan specified folders for images with size above curtain treshold. It could be run manually or easily integrated into CI.

## Installation

```bash
gem install img-lint
```

or add it to your `Gemfile` and run `bundle install`:

```ruby
gem 'img-lint', require: false
```

## Usage

Run `img-lint` in your console to lint images in the current folder or pass some arguments like so:

```bash
img-lint -p /path/to/project -f "jpg,png" -m 30
```

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
