require 'bundler' ; Bundler.require :development, :test
require 'sassy-maps'
require 'term/ansicolor'
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
Minitest::Reporters::BaseReporter.class_eval { def filter_backtrace(backtrace) ; [] ; end } # Super clean diffs.

class SassyMapsTest < Minitest::Test

  class << self

    def create_tests
      test_names.each do |file_name|
        tn = file_name.tr '/', '_'
        define_method(:"test_#{tn}") { assert_rendered_file(file_name) }
      end
    end

    def test_names
      @test_files ||= Dir["#{tests_root}/tests/**/*.{scss}"].map do |file|
        file.sub("#{tests_root}/tests/", '').sub(/\.scss/, '')
      end
    end

    def tests_root
      @tests_root ||= File.expand_path File.join(File.dirname(__FILE__))
    end

  end

  create_tests


  private

  def assert_rendered_file(file_name)
    rendered_sass = render_sass_file(file_name)
    control_sass = File.read(tests_control_file(file_name))
    flunk_sass(file_name, control_sass, rendered_sass) if control_sass != rendered_sass
  end

  def tests_root
    self.class.tests_root
  end

  def tests_output(file_name)
    file = File.join tests_root, 'output', "#{file_name}.css.diff"
    FileUtils.mkdir_p(File.dirname(file))
    file
  end

  def tests_sass_file(file_name)
    File.join tests_root, 'tests', "#{file_name}.scss"
  end

  def tests_control_file(file_name)
    File.join tests_root, 'controls', "#{file_name}.css"
  end

  def render_sass_file(file_name)
    options = {:syntax => :scss, :cache => false, :style => :expanded}
    template = File.read(tests_sass_file(file_name))
    Sass::Engine.new(template, options).render
  end

  def flunk_sass(file_name, control_sass, rendered_sass)
    diff_file = tests_output(file_name)
    diff_data = diff(control_sass, rendered_sass)
    File.open(diff_file,'w') { |f| f.write(diff_data) }
    flunk "\n" + `cdiff #{diff_file}`
  end

end
