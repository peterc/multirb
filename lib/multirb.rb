# encoding: utf-8

require_relative 'multirb/version'    # not strictly necessary, but laziness in development ;-)
require 'readline'
require 'tempfile'

module Multirb
  ALL_VERSIONS = %w{1.8.7 1.9.2 1.9.3 2.0.0 jruby}
  DEFAULT_VERSIONS = %w{1.8.7 1.9.3 2.0.0}

  RBENV_INSTALLED_VERSIONS = `rbenv versions`.split("\n").map { |version| version.delete('*').strip.split.first } if ENV['PATH']['.rbenv']

  def read_lines
    lines = []
    begin
      print "\e[0m"
      line = Readline::readline("> ")
      return nil if line.nil?
      Readline::HISTORY << line
      line.chomp!
      lines << line
      exit if line =~ /^exit$/i
    end while line =~ /\s+$/
    lines
  end

  def determine_versions(lines, defaults = DEFAULT_VERSIONS)
    defaults = DEFAULT_VERSIONS if defaults.empty?
    case lines.last
    when /\#\s?all$/
      ALL_VERSIONS
    when /\#\s?([^"']+)$/
      [*$1.strip.split(',').map(&:strip)]
    else
      defaults
    end
  end

  def create_code(lines, color)
    %{# encoding: utf-8
      ARRAY = ['a', 'b', 'c']
      HASH = { :name => "Jenny", :age => 40, :gender => :female, :hobbies => %w{chess cycling baking} }
      ARRAY2 = [1,2,3]
      STRING = "Hello"
      STRING2 = "çé"
      STRING3 = "ウabcé"
      o = begin
        "\e[#{color}" + eval(<<-'CODEHERE'
          #{lines.join("\n")}
        CODEHERE
        ).inspect + "\e[0m"
      rescue Exception => e
        "\e[31m!! \#{e.class}: \#{e.message}\e[0m"
      end
      print o}
  end

  def create_and_save_code(lines, color="32m")
    f = Tempfile.new('multirb')
    f.puts create_code(lines, color)
    f.close
    f
  end

  def run_code(*args)
    case installed_ruby_version_manager
    when :rvm
      run_rvm(*args)
    when :rbenv
      run_rbenv(*args)
    when :none
      raise "You don't have either RVM or RBENV installed"
    end
  end

  private

  def installed_ruby_version_manager
    @installed_version ||= begin
      return :rvm if ENV['PATH']['.rvm']
      return :rbenv if ENV['PATH']['.rbenv']
      :none
    end
    @installed_manager
  end

  def run_rvm(filename, version)
    cmd = `tput bold`
    cmd += `rvm #{version} exec ruby #{filename}`
    cmd
  end

  def run_rbenv(filename, version)
    cmd = `tput bold`
    cmd += `/bin/sh -c "RBENV_VERSION=#{rbenv_version(version)} ~/.rbenv/shims/ruby #{filename}"`
    cmd
  rescue ArgumentError => e # Rescue when version is not installed and print a message
    e.message
  end

  def rbenv_version(wanted_version)
    rbenv_version = RBENV_INSTALLED_VERSIONS.select {|version| version.match(/^#{wanted_version}/) }.last
    # raise error if there is not such version installed
    raise ArgumentError.new("version not installed") unless rbenv_version
    rbenv_version
  end
end
