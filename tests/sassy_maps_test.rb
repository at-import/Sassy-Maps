require 'bundler' ; Bundler.require :development, :test
require 'sassy-maps'
require 'minitest/autorun'

module SassyMaps
  class TestHelper < Minitest::Test

    def test_map_get
      assert_rendered_file '01-map-get'
    end

    def test_map_set
      assert_rendered_file '02-map-set'
    end

    def test_memo
      assert_rendered_file '03-memo'
    end


    private

    def assert_rendered_file(file_name)
      rendered_sass = render_sass_file(file_name)
      control_sass = File.read(tests_control_file(file_name))
      assert_equal control_sass, rendered_sass
    end

    def render_sass_file(file_name)
      options = {:syntax => :scss, :cache => false, :style => :expanded}
      template = File.read(tests_sass_file(file_name))
      Sass::Engine.new(template, options).render
    end

    def tests_sass_file(file_name)
      File.join tests_root, 'tests', "#{file_name}.scss"
    end

    def tests_control_file(file_name)
      File.join tests_root, 'controls', "#{file_name}.css"
    end

    def tests_root
      @tests_root ||= File.expand_path File.join(File.dirname(__FILE__))
    end

  end
end


