require 'term/ansicolor'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
Minitest::Reporters::BaseReporter.class_eval { def filter_backtrace(backtrace) ; [] ; end } # Super clean diffs.

module Navigator

  def self.create_tests(test_klass)
    test_names.each do |file_name|
      tn = file_name.tr '/', '_'
      test_klass.instance_eval do
        define_method(:"test_#{tn}") { assert_rendered_file(file_name) }
      end
    end
  end

  def self.test_names
    @test_files ||= Dir["#{tests_root}/tests/**/*.{scss}"].map do |file|
      file.sub("#{tests_root}/tests/", '').sub(/\.scss/, '')
    end
  end

  def self.tests_root
    @tests_root ||= File.expand_path File.join(File.dirname(__FILE__))
  end

  def self.tests_sass_file(file_name)
    File.join Navigator.tests_root, 'tests', "#{file_name}.scss"
  end

  def self.tests_output(file_name)
    file = File.join Navigator.tests_root, 'output', "#{file_name}.css.diff"
    FileUtils.mkdir_p(File.dirname(file))
    file
  end

  def self.tests_control_file(file_name)
    File.join Navigator.tests_root, 'controls', "#{file_name}.css"
  end


  class Renderer

    attr_reader :file_name

    class << self

      def render_sass_file(file_name)
        self.new(file_name).render
      end

      def render_controls
        Navigator.test_names.each do |file_name|
          control_css = render_sass_file(file_name)
          control_file = Navigator.tests_control_file(file_name)
          File.open(control_file,'w') { |f| f.write(control_css) }
        end
      end

    end

    def initialize(file_name)
      @file_name = file_name
    end

    def render
      options = {:syntax => :scss, :cache => false, :style => :expanded}
      template = File.read(sass_file)
      Sass::Engine.new(template, options).render
    end

    def sass_file
      Navigator.tests_sass_file(file_name)
    end

  end

  module Assertions

    def self.included(base)
      Navigator.create_tests(base)
    end

    private

    def assert_rendered_file(file_name)
      rendered_sass = Navigator::Renderer.render_sass_file(file_name)
      control_sass = File.read(Navigator.tests_control_file(file_name))
      flunk_sass(file_name, control_sass, rendered_sass) if control_sass != rendered_sass
    end

    def flunk_sass(file_name, control_sass, rendered_sass)
      diff_file = Navigator.tests_output(file_name)
      diff_data = diff(control_sass, rendered_sass)
      File.open(diff_file,'w') { |f| f.write(diff_data) }
      msg = "\n"
      msg << "Control->Compiled diff output to".colorize(:light_yellow)
      msg << " #{diff_file}\n".colorize(:light_cyan)
      msg <<  `cdiff #{diff_file}`
      flunk(msg)
    end

  end

end
