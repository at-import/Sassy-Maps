# Sassy Maps

Sassy Maps adds a variety of functions aimed at helping you work with Sass 3.3 maps much easier.

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Using Sassy Maps](#using-sassy-maps)
4. [Functions](#functions)

## Requirements

Sassy Maps is a Compass extension, so you're going to need both Sass and Compass installed. If you do not already have them installed, please read [Installing Sass and Compass Across All Platforms](http://snugug.com/musings/installing-sass-and-compass-across-all-platform). Sassy Maps 0.2.x requires *Sass 3.3.0.rc.2* and *Compass 1.0.0.alpha.13* or higher.

**It is HIGHLY RECOMMENDED that you run all Sass and Compass commands through [Bundler](http://bundler.io/)**

If the compiler you are using is not compatible with the above minimum versions, it will not compile correctly.

If you are using [CodeKit](http://incident57.com/codekit/), you are going to need to both follow the above linked instructions to install the actual Sass and Compass gems, as well as tell CodeKit to use those gems. To do so, open up CodeKit's preferences, go to Languages, and click on Compass. There will be an "Advanced Compiler Settings" section. Under that section, switch to "Use the Compass executable at this path:" option; a popup should open inside of `/usr/bin`. From there, look for `compass` and select that. You will now be able to use Compass extensions with CodeKit. Your CodeKit Compass settings should now look like this:

![CodeKit Compass settings](http://f.cl.ly/items/320z0n1b1b2Q2Q0P351R/Screen%20Shot%202013-04-03%20at%202.14.30%20PM.png)

**BE AWARE that CodeKit and most other GUI compilers *do not support Bundler* and are therefore NOT RECOMMENDED**

## Installation

The preferred way to install and use Sassy Maps is through Bundler. To do so, add the following to your Gemfile (Sass and Compass are provided to ensure the correct versions are used):

```ruby
gem "sass", "~>3.3.0.rc.2"
gem "compass", "~>1.0.0.alpha.13	"
gem "sassy-maps", "~>0.2.0"
```

Once you have done so, run `bundle install` to install your dependencies, and remember to run all of your compilation through `bundle exec`.

You can also install Sassy Maps through [Bower](http://bower.io/) as it has no Ruby requirements. To do so, run the following command:

```bash
bower install sassy-maps --save-dev
```

*BE AWARE* that while you can install Sassy Maps through Bower, Sassy Maps still only works with Sass compilers that have full compatibility with Sass 3.3.x and greater. You are also going to need to add the folder using Compass's [`add_import_path`](http://compass-style.org/help/tutorials/configuration-reference/) config option instead of the standard `require`.

## Using Sassy Maps

If you already have a project made and you'd like to use Sassy Maps with it, add the following to your `config.rb` file:

`require 'sassy-maps'`

Then, add the following to your Sass file towards the top:

`@import "sassy-maps";`

## Functions

* `map-get-deep($map, $keys...)` - Returns the value of the final item in `$keys` from the map `$map`. Will return `null` if no value is present and will warn of errors in search (such as if an intermediate depth is `null` or not a `map`).
* `map-set($map, $key, $value)` - Returns a map that has the `$key` in `$map` set to the to given `$value`.
* `map-set-deep($map, $keys, $value)` - Returns a map that has the `$key` in `$map` set to the given `$value`. `$key` should be single-depth list of keys, for instance `map-set-deep($map, ('foo' 'bar' 'baz'), "Hello World")`.
* `map-to-string($map)` - Returns a string representation of the given `$map`.
