# Sassy Maps

Sassy Maps aims to add a variety of functions and mixins aimed at helping you work with Sass 3.3 maps much easier.

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)

## Requirements

Sassy Maps is a Compass extension, so make sure you have so make sure you have [Sass and Compass installed](http://compass-style.org/install/). Some features may not be available if you are not using the Ruby compiler to compile your Sass, including this extension totally breaking.

*The minimum version of Sass required is* **Sass 3.2.0**

*The minimum version of Compass required is* **Compass 0.12.0**

If the compiler you are using is not compatible with the above minimum versions, it will not compile correctly.

## Installation

There are two ways you can install this extension; either as a [Ruby Gem](http://rubygems.org/) or as a [Bower Component](http://bower.io/). *This extension may require custom Ruby functions, and installing it as a Bower package may not work*

**RubyGems**

`gem install sassy-maps`

If installing as a Ruby Gem, Compass can then use it like any other Compass extension. You can create a new project and automatically require it:

`compass create <my_project> -r sassy-maps`

Or, you can add it to an existing project by adding the following to your `config.rb` file:

`@import "sassy-maps"`

**Bower**

`bower install sassy-maps --save-dev`

If installing as a Bower Component, you are going to need to add the path  to your `config.rb` in order to be able to use Sassy Maps as any other Compass extension. The following assumes your Bower components folder is named `bower_components` and it's at the same directory level as your `config.rb` file:

`add_import_path "bower_components/sassy-maps/sass"`